# The IdeaPad ACPI Extras kernel modules for ThinkBook 2024 NoteBooks

> UPDATE: This patch has been merged into the upstream: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.15.4&id=7f34fa4589f58c15fd82707bc9ac04da35b3c277

> For people who's kernel version >= 6.15.4, you do not need this manually patch any more.

---

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

- Kernel version < 6.15: The Fn + F4(Mute Mic func) works but [LED status not sync](https://github.com/ferstar/ideapad-laptop-tb/issues/16).

> Try this: https://github.com/ferstar/lenovo-wmi-hotkey-utilities
