Feature:
  As an 百人一首 player
  I want to search poems with string
  So I can easily select poems to use

  Background:
    Given I launch the app

  Scenario:
  テキストフィールドに文字を入力すると、歌を絞り込むことができる。
    Then I should see "百首読み上げ"

    # 「秋」と入力して
    When I forced_touch "取り札を用意する歌"
    When I wait to see "歌を選ぶ"
    When I wait for 1 second
    When I touch "search_text_field"
#    When I type "aki"
    When I use the keyboard to fill in the textfield marked "search_text_field" with "秋"
