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