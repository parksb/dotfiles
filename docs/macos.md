# macOS

- [Brewfile](../packages/Brewfile)로부터 brew 패키지 설치.
- caps lock 키가 한영 전환 기능만 하도록 변경한다.
  > The most common source of mode errors may be the Caps Lock key.
  - ~[hyperkey](https://formulae.brew.sh/cask/hyperkey)에서 caps lock을 F19로 리맵한다. 다른 옵션은 다 체크 풀어도 됨.~ macOS 15.1부터 절전모드에서 깨어날 때 앱이 동작하지 않음.
  - Hammerspoon을 사용해 caps lock 키를 F19로 리매핑한다.
    - [foundation_remapping](https://github.com/hetima/hammerspoon-foundation_remapping)을 설치한다.
    - `init.lua`에 다음 스크립트를 추가한다:
       ```
       do -- Remap Caps Lock to F19
           local remapper = require('foundation_remapping').new()
           remapper:remap('capslock', 'F19')
           remapper:register()
       end
       ```
  - system settings > keyboard shortcuts > input sources > select next source in input menu를 F19로 설정. (caps lock이 F19로 리매핑된 상태이므로 caps lock을 누르면 됨.)
- command + shift + s 키로 스크린샷을 클립보드에 붙여넣도록 한다.
  - system settings > keyboard shortcuts > screenshots > copy picture of selected area to the clipboard.
