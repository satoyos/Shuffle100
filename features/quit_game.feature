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

    When I touch "終了する"
    Then I should see "トップ"

