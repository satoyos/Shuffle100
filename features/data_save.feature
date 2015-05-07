Feature:
  As an 百人一首 player
  I want to save settings
  So I don't have to re-select same settings again.

  Background:
    Given I launch the app

  Scenario:
  設定データを永続化できる
    Then I should see "百首読み上げ"

    # 読手を選ぶ画面に進む
    When I touch "読手"
    Then I should see "読手を選ぶ"

    # 2番目の読手を選んでみる
    When I select 2nd row in picker "picker_view"

    # ホーム画面に戻ると、その読手が設定されている
    When I forcedly navigate back
    Then I should see "いなばくん"

    # 一旦シミュレータを落とす
    When I quit the simulator

    # もう一度起動すると、2番目の読手が設定されていることを確認できる
    When I launch the app
    Then I should see "いなばくん"
