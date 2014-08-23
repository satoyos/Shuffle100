Feature:
  As an 百人一首 player
  I want to go through a correct path in normal mode
  So I can see I can play with thi App.

Background:
  Given I launch the app

Scenario:
通常モードで一通りゲームを進められる。
  Then I should see "百首読み上げ"

  # 初心者モードをoffにする
  When I touch "初心者モードoff"
  Then I should see "空札"

  # 歌選択画面で、百首選ぶ
  When I touch "取り札を用意する歌"
  When I wait to see "歌を選ぶ"
  When I touch "全て選択"
  When I wait for 0.5 second
  Then I should see "100首"
  When I forced_touch "トップ"
  Then I wait to see "百首読み上げ"

  # 序歌画面
  When I touch "試合開始"
  Then I should see "序歌"
  Then I should see play_button waiting "pause"

  # 歌を百首分読み上げる
  Then I can go through 100 poems with skip


  # 最後の歌の読み上げが終了すると、終了画面が出る。
  Then I wait to see "トップに戻る"

  # 「トップに戻る」ボタンを押すと、トップ画面に戻る
  When I touch the button marked "back_to_top"
  When I wait for 1 second
  Then I should see "百首読み上げ"


