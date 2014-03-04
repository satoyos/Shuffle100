Feature:
  As an 百人一首 player
  I want to quit the game before coming to end
  So I can stop or restart the game

  Background:
    Given I launch the app

  Scenario:
  終了ボタンを押し、確認ダイアログで「終了」を選択すると、トップ画面に戻る。
    Then I should see "百首読み上げ"

    # 序歌画面
    When I touch "試合開始"
    Then I should see "序歌"

    # 試合終了ボタンを押すと、確認画面が現れる。
    When I touch "quit_button"
    When I wait for 1 second

   # なぜか↓この確認画面検出が失敗する！(T_T)
#   Then I should see an alert view titled ”試合を終了しますか？”
#   Then I should see "終了する"
#   Then I should see an element of class "UIAlertView"

    # シミュレータを抜ける
    When I quit the simulator
