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

    # ここで音量調整を試みても、落ちない。
    When I touch the button marked "gear_button"
    When I wait for 1 second
    Then I should see "いろいろな設定"
    When I touch "設定終了"
    When I wait for 1 second
    Then I should see "序歌"
    Then I should see play_button waiting "play"

    # スキップボタンを押して、早送りし、1首目の画面へ
    When I touch the button marked "forward"
    When I wait for 2 second
    Then I should see "1首め"

    # 上の句を詠み終えると、間隔を開けて、自動で下の句を読み上げる
    When I wait to see "下の句"
    When I wait for 2 second
    Then I should see play_button waiting "pause"

    # 下の句を読み終えると、「次はどうする？」画面が現れる
    When I touch the button marked "forward"
    Then I wait to see "次はどうする？"

    # 「下の句をもう一度読む」を選んだ場合
    When I wait for 0.5 second
    When I touch "下の句をもう一度読む"
    Then I should see "1首め"
    Then I should see "下の句"
    When I wait for 1 second
    #下の句の読み上げが始まる。
    Then I should see play_button waiting "pause"

    # 次に下の句を読み終えたら、「次の歌へ！」を選ぶ
    When I touch the button marked "forward"
    When I wait to see "次はどうする？"
    Then I wait for 0.5 second
    When I touch "次の歌へ！"
    When I wait for 3 second
    Then I should see "2首め"

    # 上の句を詠み終えると、間隔を開けて、自動で下の句を読み上げる
    When I wait to see "下の句"
    When I wait for 2 second
    Then I should see play_button waiting "pause"

    # 下の句を読み終えると、「次はどうする？」画面が現れる
    When I touch the button marked "forward"
    Then I wait to see "次はどうする？"

    # 「次の歌へ！」ボタンを押すと、ゲーム終了画面へ
    Then I wait for 0.5 second
    When I touch "次の歌へ！"
    Then I wait to see "トップに戻る"

    # 「トップに戻る」ボタンを押すと、トップ画面に戻る
    When I wait for 3 seconds
    When I touch "トップに戻る"
    Then I wait to see "百首読み上げ"
