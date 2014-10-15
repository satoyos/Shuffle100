Feature:
  As an 百人一首 player
  I want to quit the game before coming to end
  So I can stop or restart the game

  Background:
    Given I launch the app

  Scenario:
  読み上げ画面で終了ボタンを押し、確認ダイアログで「終了」を選択すると、トップ画面に戻る。
    Then I should see "百首読み上げ"

    # 序歌画面
    When I touch "試合開始"
    Then I should see "序歌"

    # 試合終了ボタンを押すと、確認画面が現れる。
    When I touch "quit_button"
    When I wait for 1 second

    When I touch "終了する"
    Then I should see "トップ"

  Scenario:
  「次はどうする？」終了ボタンを押し、確認ダイアログで「終了」を選択すると、トップ画面に戻る。
    Then I should see "百首読み上げ"

    # まず、初心者モードに設定する
    When I touch "初心者モードon"
    Then I should not see "空札"

    # 歌選択画面で、歌を二首選ぶ
    When I touch "取り札を用意する歌"
    When I wait to see "歌を選ぶ"
    When I touch "全て取消"
    When I touch 2 poems at random
    When I wait for 0.5 second
    Then I should see "2首"
    When I forced_touch "トップ"
    Then I wait to see "百首読み上げ"


    # 序歌画面
    When I touch "試合開始"
    Then I should see "序歌"
    When I wait for 1 second

   # スキップボタンを押して、早送りし、1首目の画面へ
    When I touch the button marked "forward"
    When I wait for 2 second
    Then I should see "1首め"

    # 下の句まで読み上げる
    When I touch the button marked "forward"
    When I wait for 2 second
    Then I wait to see "下の句"
    When I touch the button marked "forward"
    When I wait for 1 second
    Then I should see "次はどうする"

    # 試合終了ボタンを押すと、確認画面が現れる。
    When I touch "exit"
    When I wait for 1 second

    When I touch "終了する"
    When I wait for 1 second
    Then I should see "トップ"






