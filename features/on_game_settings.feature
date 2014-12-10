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

    # トップ画面でも、歯車ボタンを押すと、各種設定画面が現れる。
    When I touch "gear"
    When I wait for 1 second
    Then I should see "いろいろな設定"
    # 通常モードの時は、「上の句と下の句の間隔」セルが表示されない。
    Then I should not see "上の句と下の句の間隔"

    # トップ画面に戻る
    When I touch "設定終了"
    Then I should see "百首読み上げ"
    Then I wait for 1 second

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

# 起動時のモードは分からないが、とにかく初心者モードをonにする。
    When I touch "初心者モードon"
    Then I should not see "空札"

    # トップ画面でも、歯車ボタンを押すと、各種設定画面が現れる。
    When I touch "gear"
    When I wait for 1 second
    Then I should see "いろいろな設定"
    # 初心者モードの時は、「上の句と下の句の間隔」セルが表示される。
    Then I should see "上の句と下の句の間隔"

    # トップ画面に戻る
    When I touch "設定終了"
    Then I should see "百首読み上げ"
    Then I wait for 1 second

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

  Scenario:
  「次はどうする？」画面から「いろいろな設定」画面を呼び出せる
    Then I should see "百首読み上げ"

  # まず、初心者モードに設定する
    When I touch "初心者モードon"
    Then I should not see "空札"

  # 歌選択画面で、歌を二首選ぶ
    When I forced_touch "取り札を用意する歌"
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

  # 歯車ボタンを押すと、各種設定画面が現れる。
    When I touch "gear"
    When I wait for 1 second
    Then I should see "いろいろな設定"

    # 初心者モードの時は、「上の句と下の句の間隔」セルが表示される。
    Then I should see "上の句と下の句の間隔"

  # 「上の句と下の句の間隔」設定画面に移動できる

    When I touch "上の句と下の句の間隔"
    When I wait for 1 second
    Then I should see "試しに聞いてみる"

    # 元の「次はどうする？」画面まで戻る
    When I navigate back
    When I wait for 1 second
    When I touch "設定終了"
    When I wait for 1 second
    Then I should see "次はどうする"




