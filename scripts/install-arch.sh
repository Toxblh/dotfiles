#!/usr/bin/env bash
set -e
exit() { echo "$*" 1>&2 ; exit 1; }

USER='toxblh'
PASS='qwerty'
DEV='/dev/nvme0n1' # /vda
MOUNT='/mnt'
HOSTNAME='toxblh-arch'

logo() {
cat << EOF
 _____         _     _ _       ___           _        _ _
|_   _|____  _| |__ | | |__   |_ _|_ __  ___| |_ __ _| | | ___ _ __
  | |/ _ \ \/ / '_ \| | '_ \   | || '_ \/ __| __/ _` | | |/ _ \ '__|
  | | (_) >  <| |_) | | | | |  | || | | \__ \ || (_| | | |  __/ |
  |_|\___/_/\_\_.__/|_|_| |_| |___|_| |_|___/\__\__,_|_|_|\___|_|
EOF
}

parted_commands=$(cat << EOF
mklabel gpt
mkpart primary fat32 1MiB 300MiB
set 1 esp on
mkpart primary btrfs 300MiB 100%
quit
EOF
)

################################################################
#
# 1: Disk prepare
#
################################################################

echo "[1]: Disk prepare"

parted "$DEV" <<< "$parted_commands"

echo "[1]: Disk parted"

part_prefix="$DEV"

if [[ $part_prefix == *nvme* ]]
then
part_prefix="${part_prefix}p"
fi

mkfs.fat -F32 -n ESP "${part_prefix}1"
mkfs.btrfs -L Linux "${part_prefix}2"

echo "[1]: Created FS"

mount "${part_prefix}2" "$MOUNT"
btrfs subvolume create "$MOUNT/@"
btrfs subvolume create "$MOUNT/@home"
umount "$MOUNT"

echo "[1]: Created Subvolumes BTRFS"

opts='rw,noatime,compress=lzo,ssd,space_cache'

mount -o "$opts,subvol=@" "${part_prefix}2" "$MOUNT"

mkdir -p "$MOUNT"/{boot/efi,home}
mount "${part_prefix}1" "$MOUNT/boot/efi"

mount -o "$opts,subvol=@home" "${part_prefix}2" "$MOUNT/home"

echo "[1]: Disk complite and mounted "


################################################################
#
# 2: Install system
#
################################################################


packages=(
    # system
    base
    base-devel
    linux
    linux-firmware
    linux-headers

    # main parts
    grub
    efibootmgr
    sudo
    btrfs-progs
    xorg
    gnome

    # apps
    docker-compose
    fd
    gimp
    git
    gparted
    htop
    jq
    man-db
    man-pages
    mpv
    nano
    neofetch
    ntfs-3g
    openssh
    papirus-icon-theme
    qt5ct
    reflector
    rsync
    telegram-desktop
    terminus-font
    ttf-opensans
    vim
    wget
    whois
    zsh
    dhcpcd
)


echo "[2]: Install system packages"

set +e
pacstrap "$MOUNT" "${packages[@]}"
set -e


echo "[2]: Installed system packages"

################################################################
#
# 3: Configure system
#
################################################################


echo "[3]: genfstab..."
genfstab -U "$MOUNT" >> "$MOUNT/etc/fstab"

echo "[3]: arch-chroot start"

echo "[3]: Reflector.."
arch-chroot "$MOUNT" bash -c "reflector -p https -l 30 -n 20 --sort rate --save /etc/pacman.d/mirrorlist"

echo "[3]: Time.."
arch-chroot "$MOUNT" bash -c "ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime"

arch-chroot "$MOUNT" bash -c "ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime"
arch-chroot "$MOUNT" bash -c "timedatectl set-ntp on"
arch-chroot "$MOUNT" bash -c "hwclock --systohc"

echo "[3]: Locale.."

arch-chroot "$MOUNT" bash -c "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
arch-chroot "$MOUNT" bash -c "locale-gen"

echo "[3]: Hostname.."

arch-chroot "$MOUNT" bash -c "echo \"$HOSTNAME\" > /etc/hostname \
cat > /etc/hosts << EOF\
127.0.0.1 localhost\
::1 localhost\
127.0.1.1 $HOSTNAME.localdomain $HOSTNAME\
EOF"

echo "[3]: Nameserver.."

arch-chroot "$MOUNT" bash -c "cat > /etc/resolv.conf << EOF \
nameserver 9.9.9.9\
nameserver 1.1.1.1\
nameserver 8.8.8.8\
EOF"


echo "[3]: Create user.."
arch-chroot "$MOUNT" bash -c "useradd -m -g users -G wheel -s /bin/zsh $USER"

echo "[3]: Set user password.."
arch-chroot "$MOUNT" bash -c "echo \"$USER:$PASS\" | chpasswd"
arch-chroot "$MOUNT" bash -c "passwd -l root"


echo "[3]: Add to sudoers.."
arch-chroot "$MOUNT" bash -c "chmod 666 /etc/sudoers"
arch-chroot "$MOUNT" bash -c "echo '%wheel ALL=(ALL) ALL' > /etc/sudoers"
arch-chroot "$MOUNT" bash -c "chmod 440 /etc/sudoers"

echo "[3]: Grub install.."
arch-chroot "$MOUNT" bash -c "grub-install --target=x86_64-efi --efi-directory=/boot/efi"
arch-chroot "$MOUNT" bash -c "grub-mkconfig -o /boot/grub/grub.cfg"

echo "[3]: Systemd.."
arch-chroot "$MOUNT" bash -c "systemctl enable fstrim.timer"
arch-chroot "$MOUNT" bash -c "systemctl enable gdm"
arch-chroot "$MOUNT" bash -c "systemctl enable dhcpcd"
arch-chroot "$MOUNT" bash -c "systemctl enable NetworkManager"

echo "[3]: install yay.."
arch-chroot "$MOUNT" su -l "$USER" -c "cd /tmp\
git clone https://aur.archlinux.org/yay.git\
cd yay\
makepkg -si --noconfirm\
cd -\
rm -rf /tmp/yay"\

echo "[3]: Finish"
