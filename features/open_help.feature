Feature:
  As an 百人一首 player
  I want to refer some help screens
  So I can see how to play with this App.

Background:
  Given I launch the app

Scenario:
用意したヘルプ画面を一通り閲覧できる

#  Then I should see "百首読み上げ"
  Then I should see "百首読み上げ"

  # まず、ヘルプメニュー画面を呼び出す
  When I touch the button marked "help"
  Then I wait to see a navigation bar titled "ヘルプ"

  # 「設定できること」画面を閲覧できる
  When I wait for 1 second
#  When I touch the table cell marked "open_options_help"
  When I touch "設定できること"
  Then I wait to see a navigation bar titled "設定できること"
  When I wait for 1 second
  When I forcedly navigate back
  Then I wait to see a navigation bar titled "ヘルプ"

  #%ToDo: このテストの続きを書く！(ここまではちゃんと動いたで！)