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
        chain postrouting {
          type nat hook postrouting priority srcnat; policy accept;
          ip saddr 10.0.0.0/24 oifname != "vm*" masquerade
        }
      '';
    };
  };
}
