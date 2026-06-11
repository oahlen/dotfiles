# Nix Configuration and Dotfiles

## XPS15

![Screenshot](https://github.com/oahlen/assets/raw/main/nix-config/laptop.png)

## Desktop

![Screenshot](https://github.com/oahlen/assets/raw/main/nix-config/desktop.png)

## Installation (NixOS)

Download the latest image from [NixOS website](https://nixos.org/download/)

### Connect to a Wireless Network

Enable and start `wpa_supplicant`:

```bash
sudo systemctl start wpa_supplicant
wpa_cli
```

Connect to a new wifi network

```bash
add_network
set_setwork 0 ssid "SSID"
set_setwork 0 psk "PASSWORD"
enable_network 0
```

### Partition Disks (UEFI)

Run `sudo fdisk /dev/diskX`

```bash
g (gpt disk label)
n
1 (partition number [1/128])
2048 first sector
+500M last sector (boot sector size)
t
1 (EFI System)
n
2
default (fill up partition)
default (fill up partition)
w (write)
```

### Label Partitions and Create Filesystems

```bash
lsblk
sudo mkfs.fat -F 32 /dev/sdX1
sudo fatlabel /dev/sdX1 NIXBOOT
sudo mkfs.ext4 /dev/sdX2 -L NIXROOT
sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
```

### Generate NixOS Config

```bash
sudo nixos-generate-config --root /mnt
cd /mnt/etc/nixos/
sudo vim configuration.nix
```

### Install NixOS

```bash
cd /mnt
sudo nixos-install
```
