Feature:
As an 百人一首 player
I want to see 取り札のポップアップ
So I can see 想定している歌を選ぼうとしているかどうか確認できる。

Background:
Given I launch the app

Scenario:
歌選択画面で歌(のセル)を長押しすると、その歌の取り札画面が現れる
  Then I should see "百首読み上げ"
  When I forced_touch "取り札を用意する歌"
  Then I wait to see "歌を選ぶ"
  When I wait for 1 second
  Then I should not see "FudaLayoutView"
  When I long_touch "001"
  Then I should see "閉じる"
  Then I should see "FudaLayoutView"
  Then I should see "fuda_view"

  # 「閉じる」ボタンを押すと、取り札画面が閉じる。
  When I touch "閉じる"
  Then I should not see "FudaLayoutView"

Scenario:
初心者モードの「次はどうする？」画面で「取り札を見る」ボタンを押すと、その歌の取り札画面が現れる
    # 初心者モードをonにする
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

    # 上の句を詠み終えると、間隔を開けて、自動で下の句を読み上げる
  When I wait for 1 second
  When I touch the button marked "forward"
  When I wait to see "下の句"
  When I wait for 2 second
  Then I should see play_button waiting "pause"

    # 下の句を読み終えると、「次はどうする？」画面が現れる
  When I touch the button marked "forward"
  Then I wait to see "次はどうする？"
  Then I should see "取り札を見る"
  When I wait for 1 second
  When I touch "取り札を見る"
  Then I should see "fuda_view"

    # 「閉じる」ボタンを押すと、取り札画面が閉じる。
  When I touch "閉じる"
  Then I should not see "FudaLayoutView"



