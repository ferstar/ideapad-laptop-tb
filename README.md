# The IdeaPad ACPI Extras kernel modules for ThinkBook 2024 NoteBooks

This kernel module solves two problems:

1. Dead Sleep: The laptop turning off after closing the lid.
2. Fn+F5/6 shutdown: The laptop turning off after pressing Fn+F5 or Fn+F6(not frequently).

Tested and works on all ThinkBook 2024 models or later

## Usage

### Install via pacman for Arch Linux

```shell
sudo pacman -S ideapad-laptop-tb-dkms
```

### Install via dkms for Other Linux Distributions

```shell
make sync-source apply-patch
sudo dkms add .
sudo dkms install ideapad-laptop-tb/6.10
sudo cp dkms/blacklist-ideapad-laptop-tb-dkms.conf /etc/modprobe.d/
sudo reboot

# Uninstall
sudo dkms remove ideapad-laptop-tb/6.10 --all
sudo rm /etc/modprobe.d/blacklist-ideapad-laptop-tb-dkms.conf
sudo reboot
```

## Known bugs

~~- The Fn + F4(Mute Mic func) will not work.~~
