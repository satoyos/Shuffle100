Feature:
  As an 百人一首 player
  I want to go through a correct path
  So I can see I can play with thi App.

Background:
  Given I launch the app

Scenario:
一通りゲームを進められる。
  Then I should see "百首読み上げ"

  # 歌選択画面で、百首選ぶ
  When I touch the table cell marked "select_poem"
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

  # スキップボタンで1首目へ
  When I touch the button marked "forward"
  Then I wait to see "1首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、2首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "2首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、3首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "3首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、4首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "4首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、5首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "5首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、6首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "6首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、7首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "7首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、8首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "8首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、9首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "9首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、10首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "10首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  #################
  # No.11-20
  #################

  # スキップで下の句の読み上げが終わったら、11首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "11首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、12首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "12首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、13首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "13首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、14首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "14首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、15首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "15首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、16首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "16首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、17首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "17首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、18首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "18首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、19首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "19首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、20首めに遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "20首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  #################
  # No.21-30
  #################

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "21首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "22首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "23首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "24首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "25首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "26首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "27首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "28首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "29首め"

  # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
  When I wait for 2 seconds
  When I touch the button marked "forward"
  Then I wait to see "下"

  # スキップで下の句の読み上げが終わったら、次の歌に遷移
  When I wait for 1 second
  When I touch the button marked "forward"
  Then I wait to see "30首め"

