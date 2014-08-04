Feature:
  As an 百人一首 player
  I want to set 初心者モード of/off
  So I can play game as 初心者

  Background:
    Given I launch the app

  Scenario:
  初心者モードを「on」に設定できる。
    Then I should see "百首読み上げ"

    # 起動時のモードは分からないが、とにかく初心者モードをoffにする。
    When I touch "初心者モードoff"
    Then I should see "空札"

    #BD_Viewのボタンを押す
    When I touch "初心者モードon"
    Then I should not see "空札"

    # 序歌画面
    When I touch "試合開始"
    Then I should see "序歌"
    When I wait for 1 second

    # スキップボタンを押して、早送りし、1首目の画面へ
    When I touch the button marked "forward"
    When I wait for 2 second
    Then I should see "1首め"

    # 上の句を詠み終えると、間隔を開けて、自動で下の句を読み上げる
    When I wait to see "下の句"
    When I wait for 2 second
     # ↓ 競技かるたモード
#    Then I should see a "play" button
     # ↓ 初心者モード
    Then I should see a "pause" button
