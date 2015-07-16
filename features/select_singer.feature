Feature:
  As an 百人一首 player
  I want to seledt 読手
  So I can play with favorite voice

  Background:
    Given I launch the app

  Scenario:
  好きな音声を選択できる
    Then I should see "百首読み上げ"

    # 読手を選ぶ画面に進む
    When I touch "読手"
    Then I should see "読手を選ぶ"

    # 1番目の読手を選んでみる
    When I select 1st row in picker "picker_view"

    # ホーム画面に戻ると、その読手が設定されている
    When I forcedly navigate back
    Then I should see "IA"

    # 改めて読手を選ぶ画面に進む
    When I wait for 1 second
    When I touch "読手"
    Then I should see "読手を選ぶ"

    # 今度は、2番目の読手を選んでみる
    When I select 2nd row in picker "picker_view"

    # ホーム画面に戻ると、その読手が設定されている
    When I forcedly navigate back
    Then I should see "いなばくん"
