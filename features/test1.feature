Feature:
  As an 百人一首 player
  I want to go through a correct path
  So I can see I can play with thi App.

Background:
  Given I launch the app

Scenario:
一通りゲームを進められる。
  Then I should see "百首読み上げ"
  
  # 序歌画面
  When I touch "試合開始"
  Then I should see "序歌"
  Then I should see play_button waiting "pause"
  Then I should not see play_button waiting "play"
  
  # 自動的に1首目へ
  Then I wait to see "1/"

  # 上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  Then I wait to see "下"

  # Playボタンを押すと、下の句の読み上げが始まる
  When I touch the button marked "play_button"
  Then I should see play_button waiting "pause"

  # 自動的に2首目へ
  Then I wait to see "2/"

  # 上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  Then I wait to see "下"

  # Playボタンを押すと、下の句の読み上げが始まる
  When I touch the button marked "play_button"
  Then I should see play_button waiting "pause"

  # 自動的に3首目へ
  Then I wait to see "3/"

  # 上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  Then I wait to see "下"

  # Playボタンを押すと、下の句の読み上げが始まる
  When I touch the button marked "play_button"
  Then I should see play_button waiting "pause"

  # 最後の歌の読み上げが終了すると、終了画面が出る。
  Then I wait to see "トップに戻る"
  


  Scenario:
早送りのボタンを押すと、すぐに次の歌に進む。
  Then I should see "百首読み上げ"

  # 序歌画面
  When I touch "試合開始"
  Then I should see "序歌"

  # 早送りスキップボタンを押す
  When I touch the button marked "forward"
  When I wait for 2 seconds
  Then I should see "1/"