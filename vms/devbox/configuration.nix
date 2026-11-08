{ ... }:
{
  networking.hostName = "devbox";

  microvm = {
    vcpu = 8;
    mem = 12 * 1024;
  };

  features = {
    persistence.enable = true;
    podman.enable = true;
  };
}
