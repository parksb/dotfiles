# macOS

- [Brewfile](../packages/Brewfile)로부터 brew 패키지 설치.
- caps lock 키가 한영 전환 기능만 하도록 변경한다.
  > The most common source of mode errors may be the Caps Lock key.
  - [hyperkey](https://formulae.brew.sh/cask/hyperkey)에서 caps lock을 F19로 리맵한다. 다른 옵션은 다 체크 풀어도 됨.
  - system settings > keyboard shortcuts > input sources에서 select next source in input menu를 F19로 설정. (caps lock이 F19로 리매핑된 상태이므로 caps lock을 누르면 됨.)
