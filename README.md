# Nix configuration and dotfiles

## XPS15

![Screenshot](https://github.com/oahlen/assets/raw/main/nix-config/laptop.png)

## Desktop

![Screenshot](https://github.com/oahlen/assets/raw/main/nix-config/desktop.png)

## Installation (NixOS)

Download the latest image from [NixOS website](https://nixos.org/download/)

### Connect to a wireless network

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

### Partition disks (UEFI)

Run `sudo fdisk /dev/diskX`

1. g (gpt disk label)
2. n
3. 1 (partition number [1/128])
4. 2048 first sector
5. +500M last sector (boot sector size)
6. t
7. 1 (EFI System)
8. n
9. 2
10. default (fill up partition)
11. default (fill up partition)
12. w (write)

### Label partitions and create file systems

1. lsblk
2. sudo mkfs.fat -F 32 /dev/sdX1
3. sudo fatlabel /dev/sdX1 NIXBOOT
4. sudo mkfs.ext4 /dev/sdX2 -L NIXROOT
5. sudo mount /dev/disk/by-label/NIXROOT /mnt
6. sudo mkdir -p /mnt/boot
7. sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot

### Generate NixOS config

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
