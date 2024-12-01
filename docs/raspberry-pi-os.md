# Raspberry Pi OS

> Raspberry Pi OS Lite (64 bit)

일단 패키지를 업그레이드한다.

```sh
$ sudo apt update
$ sudo apt full-upgrade
```

루트 비밀번호를 설정한다.

```sh
$ sudo passwd root
```

SSH 서버 설정을 변경한다.

```sh
$ sudo vi /etc/ssh/sshd_config
> PasswordAuthentication no # 비밀번호 인증 비활성화
> PermitRootLogin no # 루트 계정 로그인 차단
> ChallengeResponseAuthentication no
> UsePAM no
```

필요하다면 SSH 포트도 변경한다.

```sh
$ sudo vi /etc/ssh/sshd_config
> Port 2222
$ sudo vi /etc/services
> ssh 2222/tcp
$ sudo reboot
```

SSH 클라이언트는 22번 포트를 사용하도록 한다. 서버 포트만 바꿨는데 클라이언트도 다른 포트를 바라본다. (SSH를 통해 `git clone`할 때 문제를 겪었다.)

```sh
$ sudo vi /etc/ssh/ssh_config
> Port 22
```

포트를 변경했어도 외부로 공개하면 스팸 접속 시도가 들어온다. 라우터에서 포트포워딩하지 말고, 웬만하면 Tailscale을 사용하는 것이 낫다.

이어서 방화벽을 설정한다.

```sh
$ sudo apt install ufw
$ sudo ufw status # 상태 확인 (기본 비활성화 상태)
$ sudo ufw allow 2222/tcp # SSH 포트 허용
$ sudo ufw enable # 방화벽 활성화
```

유동 아이피 네트워크라면 DDNS를 사용해야 한다. ddclient를 설치하고, Cloudflare를 사용 중이라면 https://github.com/ddclient/ddclient.github.io/pull/7 참고해서 `/etc/ddclient.conf`를 작성한다.

```sh
$ apt install ddclient
```

모니터링을 위해 netdata를 설치한다. 프로메테우스보다 리소스를 적게 쓰고, 그 외 다른 모니터링 툴보다 강력하다. 웬만하면 도커로 설치한다: https://learn.netdata.cloud/docs/netdata-agent/installation/docker

netdata.config 파일을 호스트에서 수정할 일이 많으니 볼륨대신 `/etc/netdata` 디렉토리를 바인드 마운트한다. 호스트에 `/etc/netdata` 디렉토리를 만들고, `netdata.config` 파일을 복사해 넣어둔다. 기본 포트는 19999인데 포트를 바꾸고 싶다면 `[web] default port`를 수정한다.

로컬호스트에는 기본적으로 열리니까 SSH 터널링해서 접속하면 되고, `[web] bind to = 0.0.0.0`으로 설정하면 포트가 공개된다. 단, 아무나 접근하면 안 되니까 `ufw`로 동일망 내에서만 접속할 수 있도록 제한한다. 아니면 아예 netdata 클라우드만 사용한다.

파이의 CPU 온도를 모니터링하려면 빌트인된 컬렉터를 사용한다. 디폴트로는 꺼져있기 때문에 직접 활성화해야 한다: https://learn.netdata.cloud/docs/collecting-metrics/hardware-devices-and-sensors/linux-sensors-sysfs

```sh
cd /etc/netdata
sudo ./edit-config chars.d.conf
> sensors=force
```
