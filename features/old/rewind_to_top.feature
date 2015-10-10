Feature:
  As an 百人一首 player
  I want to check if app goes back to Top when rewind button gets pushed
  So I can see I can play safely

  Background:
    Given I launch the app

  Scenario:
  序歌画面から、rewindボタンでトップ画面に戻る。
    Then I should see "百首読み上げ"

    # 序歌画面
    When I touch "試合開始"
    Then I should see "序歌"

    # 序歌を読み上げ中にrewindボタンを押すと、PlayButtonが再生待ち状態になる。
    When I touch the button marked "rewind"
    Then I should see play_button waiting "play"

    # その状態で、もう一度rewindボタンを押すと、今度はTop画面に戻る
    When I touch the button marked "rewind"
    When I wait for 1 second
    Then I should see "百首読み上げ"

  Scenario:
  第1首目の読み上げ画面からも、rewindボタンでトップ画面に戻る。
    Then I should see "百首読み上げ"

    # 序歌画面
    When I touch "試合開始"
    Then I should see "序歌"

    # スキップボタンを押し、第1首に移動
    When I touch the button marked "forward"
    Then I wait to see "1首め"
    When I wait for 2 second

    # 第1首を読み上げ中にrewindボタンを押すと、PlayButtonが再生待ち状態になる。
    When I touch the button marked "rewind"
    Then I should see play_button waiting "play"

    # その状態で、もう一度rewindボタンを押すと、今度はTop画面に戻る
    When I touch the button marked "rewind"
    When I wait for 1 second
    Then I should see "百首読み上げ"


