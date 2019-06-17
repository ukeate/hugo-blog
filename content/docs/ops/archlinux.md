---
Categories: ["运维"]
Tags: ["linux"]
title: "Archlinux安装"
date: 2018-10-08T20:31:09+08:00
---



# 设置

        ahci, secure boot, post behavious thorough

# 源

        vim /etc/pacman.d/mirrorlist
        pacman -Syy

# 依赖

        base-devel

# 分区

        # mount -t efivarfs efivarfs /sys/firmware/efi/efivars
                # 判断efi
        cfdisk
        mkfs.vfat -F32 /dev/nvme0n1p1
                # 或直接使用windows的uefi分区
        mkfs.ext4 /dev/nvme0n1p2
        mkswap /dev/nvme0n1p3
        swapon /dev/nvme0n1p3
        mount /dev/nvme0n1p2 /mnt
        mkdir -p /mnt/boot/EFI
        mount /dev/nvme0n1p1 /mnt/boot/EFI

# 配置

        pacstrap -i /mnt base
        genfstab -U -p /mnt >> /mnt/etc/fstab
        arch-chroot /mnt /bin/bash
        pacman -S dialog wpa_supplicant vim 
        vim /etc/locale.gen
        locale-gen
        echo LANG=en_US.UTF-8 > /etc/locale.conf
        ls -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
        hwclock --systohc --utc
        echo outrun > /etc/hostname

# grub

        pacman -S dosfstools grub os-prober efibootmgr
                # bios下 grub os-prober 
        grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=grub
        grub-mkconfig -o /boot/grub/grub.cfg

# 用户

        passwd
        groupadd outrun
        useradd -m -g users -G outrun -s /usr/bin/bash outrun
        passwd outrun
        vim /etc/sudoers

# 退出

        exit
        umount -R /mnt
        reboot

# 桌面

        pacman -S xorg-server xorg-apps xorg xorg-xinit
        pacman -S xf86-video-intel mesa xf86-input-synaptics
        pacman -S gnome
        echo exec gnome-session > .xinitrc
        # systemctl enable gdm
        /etc/modprobe.d/blacklist_nouveau.conf中写blacklist nouveau
        /etc/modprobe.d/modprobe.conf中写blacklist nouveau
        pacman -S ttf-dejavu wqy-microhei

# network

        pacman -S networkmanager-openvpn
        systemctl enable NetworkManager

# yaourt

        vim /etc/pacman.conf
                [archlinuxfr]
                        SigLevel = Never
                        Server = http://repo.archlinux.fr/$arch
        pacman -Sy base-devel yaourt