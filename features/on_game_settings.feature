Feature: As an 百人一首 player
  I want to change some settings when playing games
  So I can change 歌間隔 or 音量 etc..

  Background:
    Given I launch the app

  Scenario:
  通常モードでの「いろいろな設定」画面の確認
    Then I should see "百首読み上げ"

# 起動時のモードは分からないが、とにかく初心者モードをoffにする。
    When I touch "初心者モードoff"
    Then I should see "空札"

  # 序歌画面
    When I touch "試合開始"
    Then I should see "序歌"

  # 歯車ボタンを押すと、各種設定画面が現れる。
    When I touch "gear_button"
    When I wait for 1 second
    Then I should see "いろいろな設定"

    # 通常モードの時は、「上の句と下の句の間隔」セルが表示されない。
    Then I should not see "上の句と下の句の間隔"

  # 最初のテーブルセルを押すと、歌間隔設定画面に遷移する。

    When I touch "歌と歌の間隔"
    When I wait for 1 second
    Then I should see "歌の間隔の変更"

  Scenario:
  初心者モードでの「いろいろな設定」画面の確認
    Then I should see "百首読み上げ"

# 起動時のモードは分からないが、とにかく初心者モードをoffにする。
    When I touch "初心者モードon"
    Then I should not see "空札"

  # 序歌画面
    When I touch "試合開始"
    Then I should see "序歌"

  # 歯車ボタンを押すと、各種設定画面が現れる。
    When I touch "gear_button"
    When I wait for 1 second
    Then I should see "いろいろな設定"

    # 初心者モードの時は、「上の句と下の句の間隔」セルが表示される。
    Then I should see "上の句と下の句の間隔"

  # 「上の句と下の句の間隔」設定画面に移動できる

    When I touch "上の句と下の句の間隔"
    When I wait for 1 second
    Then I should see "試しに聞いてみる"


