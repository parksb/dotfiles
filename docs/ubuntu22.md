# Ubuntu 22

1. macOS 스타일로 키매핑: https://github.com/rbreaves/kinto#how-to-install-linux
    > [!IMPORTANT]
    > 파이썬이 설치되어 있어야 한다.
    - `gnome-tweak` > Keyboard & Mouse > Overview Shortcut을 Right Super로 변경.
2. caps lock 비활성화 및 한영 전환키를 caps lock으로 설정.
    1. caps lock을 hyper key로 설정: `gnome-tweaks` > Keyboard & Mouse > Additional Layout Options > Caps Lock behavior > Make Caps Lock an additional Hyper 체크.
    2. 한영 전환키를 hyper key로 설정: Settings > Keyboard > Korean (Hangul) Preferences > Hangul Toggle Key Add.
3. 하이버네이트 활성화: https://linuxhint.com/enable-hibernate-ubuntu-22-04-lts/
    1. 스왑 파티션 사이즈가 메모리 사이즈와 같거나 커야 한다. 작다면 스왑 사이즈를 늘려야 한다.
        ```
        $ sudo swapoff /swapfile
        $ sudo dd if=/dev/zero of=/swapfile bs=1MB count=$((<size(GB)>*1024)) status=progress
        $ sudo chmod 600 /swapfile
        $ sudo mkswap /swapfile
        $ sudo swapon /swapfile
        ```
    2. 스왑 영역이 부팅 시 활성화되는지 확인한다: `sudo cat /etc/fstab`
        > [!NOTE]
        > `fstab` 내용에 `/swapfile`이 있어야 한다.
    3. 스왑 파일의 첫 번째 physical offset 시작점을 확인한다: `sudo filefrag -v /swapfile | head --lines=10`
    4. 루트 파티션의 이름을 확인한다: `fdisk -l` 또는 `df -h /`
    5. 루트 파티션의 파일 시스템 UUID를 확인한다: `sudo blkid /dev/<root>`
    6. GRUB이 하이버네이트된 시스템을 재개할 수 있도록 설정한다:
        ```
        $ sudo vi /etc/default/grub
        ...
        GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
        ...
        ```
        위 라인을 아래와 같이 변경한다. 앞서 확인한 파일 시스템 UUID와 physical offset을 명시한다.
        ```
        $ sudo vi /etc/default/grub
        ...
        GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=<uuid> resume_offset=<offset>"
        ...
        ```
        GRUB을 업데이트한다: `sudo update-grub`
    7. initramfs의 resume 설정을 작성하고 업데이트한다:
        ```
        $ sudo vi /etc/initramfs-tools/conf.d/resume
        RESUME=UUID=<uuid> resume_offset=<offset>
        $ sudo update-initramfs -c -k all
        ```
    8. 전원 시스템 트레이 메뉴에 하이버네이트 옵션을 추가한다:
        ```
        $ sudo vi /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla
        [Re-enable hibernate by default in upower]
        Identity=unix-user:*
        Action=org.freedesktop.upower.hibernate
        ResultActive=yes

        [Re-enable hibernate by default in logind]
        Identity=unix-user:*
        Action=org.freedesktop.login1.hibernate;org.freedesktop.login1.handle-hibernate-key;org.freedesktop.login1;org.freedesktop.login1.hibernate-multiple-sessions;org.freedesktop.login1.hibernate-ignore-inhibit
        ResultActive=yes
        ```
    9. GNOME 익스텐션 매니저 앱을 설치한다: `sudo apt install gnome-shell-extension-manager`
    10. 앱을 열고 "Hibernate Status Button" 익스텐션을 설치한 뒤 재부팅한다.
4. SSH 서버 설정 (`/etc/ssh/sshd_config`):
  1. 비밀번호 인증 비활성화: `PasswordAuthentication no`
  2. root 계정 접근 차단: `PermitRootLogin no`
  3. X11 포워딩: `X11Forwarding yes`
    - 리모트에서는 `ssh -X user@hostname`으로 접속.
    - macOS: [XQuartz](https://www.xquartz.org/)
  4. SSH 서버 재실행: `systemctl restart sshd`
