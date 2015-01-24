Feature:
  As an 百人一首 player
  I want to select poems to sing
  So I can determine length of the game.

  Background:
    Given I launch the app

  Scenario:
  「1文字目で選ぶ」画面の選択結果が正しく反映される。
    Then I should see "百首読み上げ"

  # 歌選択画面で、百首選ぶ
    When I forced_touch "取り札を用意する歌"
    When I wait to see "歌を選ぶ"
    When I touch "全て選択"
    Then I should see "100首"
    When I touch "全て取消"
    Then I should see "0首"

  # 「1文字目で選ぶ」画面に遷移
    When I touch "1字目で選ぶ"
    Then I should see "一字決まりの歌"

