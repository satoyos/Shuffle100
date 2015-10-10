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
  When I touch "設定できること"
  Then I wait to see a navigation bar titled "設定できること"
  When I wait for 1 second
  When I forcedly navigate back
  Then I wait to see a navigation bar titled "ヘルプ"

  # 「このアプリを評価する」を選ぶ
  When I wait for 1 second
  When I touch "このアプリを評価する"
  Then I wait to see "立ち上げる"

  # 確認ダイアログでキャンセルする
  When I touch "やめておく"
  Then I should not see "立ち上げる"

  # もう一度「このアプリを評価する」を選んで…
  When I wait for 1 second
  When I touch "このアプリを評価する"
  Then I wait to see "立ち上げる"

  # 今度は「立ち上げる」を推してみる
  When I touch "立ち上げる"
  Then I should not see "立ち上げる"
  # シミュレータではApp Storeアプリが起動しないので、何も起こらない。(クラッシュしないことだけ確認)
  Then I wait for 1 second
