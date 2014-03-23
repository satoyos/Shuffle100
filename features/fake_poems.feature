Feature:
  As an 百人一首 player
  I want to set fake_switch of/off
  So I can play game with 空札

  Background:
    Given I launch the app

  Scenario:
  空札を設定できる。
    Then I should see "百首読み上げ"

    # 歌選択画面で、歌を三首選ぶ
    When I touch the table cell marked "select_poem"
    When I wait to see "歌を選ぶ"
    When I touch "全て取消"
    When I touch 3 poems at random
    When I wait for 0.5 second
    Then I should see "3首"
    When I forced_touch "トップ"
    Then I wait to see "百首読み上げ"

    # 空札スイッチをonに設定
    When I flip switch "空札を加える" on
    Then switch "空札を加える" should be on

    # 序歌画面
    When I touch "試合開始"
    Then I should see "序歌"
    When I wait for 1 second

    # スキップボタンを押して、早送りし、1首目の画面へ
    When I touch the button marked "forward"

    # その画面で、読み上げられる歌の総数をチェック
    When I wait for 2 seconds
    Then I should see "全6首"



