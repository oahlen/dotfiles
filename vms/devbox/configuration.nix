{ ... }:
{
  networking.hostName = "devbox";

  microvm = {
    vcpu = 8;
    mem = 12 * 1024;
    vsock.cid = 3; # Lowest number a VM can have
  };
}
