Feature:
  As an 百人一首 player
  I want to set 初心者モード of/off
  So I can play game as 初心者

  Background:
    Given I launch the app

  Scenario:
  初心者モードを「on」に設定できる。
    Then I should see "百首読み上げ"

    # 起動時のモードは分からないが、とにかく初心者モードをoffにする。
    When I touch "初心者モードoff"
    Then I should see "空札"

    #BD_Viewのボタンを押す
    When I touch "初心者モードon"
    Then I should not see "空札"

    #%ToDo: 次は、初心者モード・スイッチをoffにするボタンを作るところから！