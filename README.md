![image](https://user-images.githubusercontent.com/2198153/90152074-50899380-dd7f-11ea-9fba-ce4fdfea7929.png)
# Toxblh dotfiles

## How to use (linux)
- `./backup.sh` for backup all configs in list.conf
- `./restore.sh` for restore all configs in .config folder

## Operating Systems:
- MacOS
- Linux (Manjaro/Arch)

Linux desktop
![](assets/low-res.jpg)

# How to install arch with script
0. Download Arch ISO, to burn it to flash and restart with the usb stick
1. Check internet like `ping ya.ru`. If need wifi:
```
> iwctl

device list
station %device% scan
station %device% get-networks
station %device% connect %SSID%
```
2. `curl -L -o install.sh https://bit.ly/2YLvWO1`
3. `nano install.sh` change here user|password|device|hostname to you
4. `chmod +x ./install.sh`
5. `./install.sh`
