# https://microvm-nix.github.io/microvm.nix/routed-network.html
{
  config,
  lib,
  ...
}:
let
  cfg = config.features.microvm;
  registry = import ./registry.nix;
in
lib.mkIf (cfg.vms != [ ]) {
  # networkd only manages the tap links, NetworkManager keeps the rest
  systemd.network = {
    enable = true;

    networks = lib.listToAttrs (
      map (
        name:
        let
          index = toString registry.${name};
        in
        lib.nameValuePair "30-vm${index}" {
          matchConfig.Name = "vm${index}";
          address = [ "10.0.0.0/32" ];
          routes = [ { Destination = "10.0.0.${index}/32"; } ];
          networkConfig = {
            IPv4Forwarding = true;
            LinkLocalAddressing = "no";
            IPv6AcceptRA = false;
          };
          linkConfig.RequiredForOnline = "no";
        }
      ) cfg.vms
    );
  };

  networking.networkmanager.unmanaged = [ "interface-name:vm*" ];

  # Return traffic arrives on the uplink, which must forward too
  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = true;

  networking.nftables = {
    enable = true;

    tables.microvm = {
      family = "inet";
      content = ''
        # Everything that is not the public internet
        set nonpublic4 {
          type ipv4_addr
          flags interval
          elements = {
            0.0.0.0/8,          # "this" network
            10.0.0.0/8,         # RFC 1918
            100.64.0.0/10,      # CGNAT, also used by tailscale
            127.0.0.0/8,        # loopback
            169.254.0.0/16,     # link-local
            172.16.0.0/12,      # RFC 1918
            192.0.0.0/24,       # IETF protocol assignments
            192.168.0.0/16,     # RFC 1918
            198.18.0.0/15,      # benchmarking
            224.0.0.0/4,        # multicast
            240.0.0.0/4,        # reserved, includes broadcast
          }
        }

        # VMs never reach services on the host itself, only replies to
        # host-initiated traffic are let through. Drop here is final, other
        # tables accepting the packet does not override it.
        chain input {
          type filter hook input priority filter; policy accept;
          iifname "vm*" ct state established,related accept
          iifname "vm*" drop
        }

        chain forward {
          type filter hook forward priority filter; policy accept;
          iifname "vm*" meta nfproto ipv6 drop
          oifname "vm*" meta nfproto ipv6 drop
          iifname "vm*" oifname "vm*" drop
          iifname "vm*" ip daddr @nonpublic4 drop
          oifname "vm*" ct state established,related accept
          oifname "vm*" drop
        }

        chain postrouting {
          type nat hook postrouting priority srcnat; policy accept;
          ip saddr 10.0.0.0/24 oifname != "vm*" masquerade
        }
      '';
    };
  };
}
