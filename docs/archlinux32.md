# Arch Linux 32 on BIOS

> https://archlinux32.org/

아치 리눅스는 2017년 이후로 i686 아키텍처 지원을 종료했다. 따라서 커뮤니티 주도로 유지보수되고 있는 Arch Linux 32를 사용해야 한다. 기본 설치 과정은 [wiki.archlinux.org/Installation_guide](https://wiki.archlinux.org/title/Installation_guide)와 동일하지만, 예상치 못한 문제가 발생할 수 있다.

## Pre-installation

### Prepare an installation medium

1. PGP 서명(.iso.sig)과 이미지(.iso)를 [다운로드](https://www.archlinux32.org/download/)한다.
    > [!Important]
    > i686 머신에 설치하는 것이 목표이므로 Arch Linux 32 이미지를 받아야 한다.
2. 서명을 검증한다: `gpg --keyserver-options auto-key-retrieve --verify archlinux32-{version}-i686.iso.sig`
3. 설치 매체(USB 등)를 부팅 디스크로 만든다.
4. 대상 머신에 설치 매체를 연결하고 BIOS에 진입한다.
5. Secure boot 옵션을 비활성화하고, 설치 매체를 1순위 부팅 옵션으로 설정한다.
6. 저장하고 나간 뒤 설치 매체로 부팅하여 아치 리눅스 설치를 시작한다.

### On the installation medium

1. BIOS로 부팅했는지 확인한다. `ls /sys/firmware/efi`를 입력했을 때 파일이 없어야 한다.
    > [!Important]
    > 파일이 있다면 UEFI로 부팅한 것이므로, 이 가이드를 따라서는 안 된다.
2. 인터넷에 연결한다. 이더넷은 자동으로 잡히지만, 와이파이는 직접 연결해야 한다.
    1. 네트워크 인터페이스가 활성화되어 있는지 확인한다.
        ```
        > ip link
        ```
    2. 디바이스가 블락됐는지 확인한다.
        ```
        > rfkill
        ```
    3. 와이파이에 연결한다.
        ```
        > iwctl
        [iwctl]> device list
        [iwctl]> station wlan0 scan
        [iwctl]> station wlan0 get-networks
        [iwctl]> station wlan0 connect {ssid}
        [iwctl]> exit
        ```
    4. 연결이 잘 됐는지 확인한다.
        ```
        > ping -c3 archlinux.org
        ```
3. 시스템 시계가 NTP를 사용하도록 설정한다.
    ```
    > timedatectl set-ntp true
    > timedatectl
    ```
4. [`fdisk`](https://wiki.archlinux.org/title/fdisk)로 디스크 목록을 확인하고 주디스크를 선택한다.
5. 불필요한 파티션들을 지우고(`d`), 새로 만든 뒤(`n`) 파티션 타입을 변경(`t`)한다.
6. 예시 레이아웃: [wiki.archlinux.org/Partitioning](https://wiki.archlinux.org/title/Partitioning#Example_layouts)
7. 저장(`w`)하고 루트 파티션을 EXT4로 포맷한다: `mkfs.ext4 /dev/{root}`
8. 스왑 파티션을 초기화한다: `mkswap /dev/{swap}`
9. 루트 파티션을 `/mnt` 디렉토리에 마운트한다: `mount /dev/{root} /mnt`
10. 스왑 파티션을 활성화한다: `swapon /dev/{swap}`

## Installation

### Out of `/mnt`

1. 필수 패키지를 설치한다: `pacstrap -K /mnt base linux linux-firmware`
    > [!NOTE]
    > 서명을 신뢰할 수 없다는 에러가 발생할 수 있다. 이 경우 아래와 같이 키링을 업그레이드한다.
    ```
    > pacman-key --populate
    > pacman-key -Sy archlinux-keyring
    > pacman-key -Sy archlinux32-keyring
    ```
    더 자세한 내용은 [wiki.archlinux.org/Pacman/Package_signing](https://wiki.archlinux.org/title/Pacman/Package_signing)을 참고.
2. `fstab` 파일을 생성한다: `genfstab -U /mnt >> /mnt/etc/fstab`
3. `/mnt`로 루트를 변경한다: `arch-chroot /mnt`

### In `/mnt`

1. 타임존은 설정한다: `ln -sf /usr/share/zoneinfo/ROK /etc/localtime`
2. `/etc/adjtime` 파일을 생성한다: `hwclock --systohc`
3. 로케일 파일을 생성한다: `locale-gen`
4. `/etc/hostname` 파일을 만든다: `echo {my-hostname} > /etc/hostname`
5. 루트 계정의 패스워드를 설정한다: `passwd`
6. 부트로더를 설치한다.
    1. 앞서 부트 파티션을 따로 설정하지 않았으므로, 루트 파티션을 사용한다.
    2. BIOS에 ext4 파일 시스템을 사용 중이므로 부트로더는 GRUB을 사용한다: `pacman -S grub`
        > [!NOTE]
        > 서명을 신뢰할 수 없다는 에러가 발생하면 키링을 업그레이드 해준다.
    3. GRUB을 설치한다: `grub-install --target=i386-pc /dev/{disk}`
        > [!IMPORTANT]
        > 이때 `{disk}`는 파티션이 아니라 디스크라는 점에 주의한다.
7. 텍스트 에디터를 설치한다: `pacman -S neovim`
8. 네트워크 설정을 한다:
    > [!IMPORTANT]
    > 여기서 네트워크 설정을 하지 않으면 설치 이후 설치 매체를 사용해 다시 설정해야 한다.
    1. `iwd`를 설치한다: `pacman -S iwd`
    2. `systemctl enable iwd systemd-networkd systemd-resolved`
9. `chroot` 환경을 빠져나온다: `exit`

## Post-installation

1. 마운팅된 파티션을 언마운트한다: `unmount -R /mnt`
2. 머신을 종료하고 설치 매체를 제거한다.
3. 재부팅하여 BIOS에서 부팅 옵션 우선순위를 확인한 뒤 저장하고 나온다.
4. 이제 [wiki.archlinux.org/General_recommendations](https://wiki.archlinux.org/title/General_recommendations)를 따른다.
