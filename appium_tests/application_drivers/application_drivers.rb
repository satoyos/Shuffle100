require_relative 'string_with_utf8_mac'

# GUI Element Type

TYPE_STATIC_TEXT = 'XCUIElementTypeStaticText'
TYPE_BUTTON = 'XCUIElementTypeButton'
TYPE_CELL = 'XCUIElementTypeCell'
TYPE_SWITCH = 'XCUIElementTypeSwitch'
TYPE_PICKER_WHEEL = 'XCUIElementTypePickerWheel'
TYPE_SEARCH_FIELD = 'XCUIElementTypeSearchField'

# TEXT_ON_SCREEN
STR_ADD_FAKE_POEMS = '空札を加える'
STR_ADD_THESE_20 = '今選んでいる札に加える'
STR_CLOSE = '閉じる'
STR_FIVE_COLORS_SCREEN = '五色百人一首'
STR_FUDA_SET_LIST = '作った札セットから選ぶ'
STR_INABA_KUN = 'いなばくん（人間）'
STR_NGRAM_PICKER = '1字目で選ぶ'
STR_ONE_CHAR_KIMARI = '一字決まりの歌'
STR_POEM_SELECTION = '取り札を用意する歌'
STR_SELECT_BY_FIVE_COLORS = '「五色百人一首」の色で選ぶ'
STR_SELECT_BY_GROUP = 'まとめて選ぶ'
STR_SELECT_FROM_FUDA_SETS = '作った札セットから選ぶ'
STR_SELECT_JUST_20 = 'この20首だけを選ぶ'
STR_SELECT_POEM_SCREEN = '歌を選ぶ'
STR_SINGER = '読手'
STR_START_GAME = '試合開始'


# Accessibility ID of UI Elements
ID_SEARCH_TEXT_FIELD = 'search_text_field'


def can_see(text)
  expect(elems_of_str(text)).not_to be_empty
end

def can_not_see(text)
  expect(elems_of_str(text)).to be_empty
end

def close_whats_next_screen
  click_button(STR_CLOSE)
end

def current_screen_is(name)
  expect(navigation_bar_of_name(name)).not_to be nil
end

def fill_search_window_with_text(str)
  find_element(:class_name, TYPE_SEARCH_FIELD).send_keys str
end

def get_filtered_cell_names
  find_elements(:class_name, TYPE_CELL).map {|e| e.name}
end

def goto_select_poem_screen
  click_element_with_text STR_POEM_SELECTION
end

def goto_select_singer_screen
  click_element_with_text(STR_SINGER)
end

def open_first_char_select_screen
  sleep_while_animation
  click_button(STR_NGRAM_PICKER)
  sleep_while_animation
  current_screen_is STR_NGRAM_PICKER
end

def open_fuda_set_list_screen
  sleep_while_animation
  click_button(STR_SELECT_FROM_FUDA_SETS)
  current_screen_is STR_FUDA_SET_LIST
end

def open_game
  open_game_without_check
  can_see(JOKA)
end

def open_game_without_check
  click_element_with_text(STR_START_GAME)
end

def recite_screen_title_matches(regexp)
  # 読み上げ画面のヘッダのラベルにacccessibilityLabelを設定すると、
  # Appium Test上では、そのラベルのaccessibility_idだけでなく、labelやnameもすべてその値に書き換わり、
  # 実際にどのような文字列が書かれているのかが取得できなくなる。
  # なので、不本意ながら、「最初に取得できるテキストラベル」を「読み上げ画面のヘッダラベル」とみなす。
  expect(first_text_content).to match_regex regexp
end

def select_by_group
  sleep 2.0
  click_button(STR_SELECT_BY_GROUP)
end

def select_one_char_kimari
  click_element_with_text(STR_ONE_CHAR_KIMARI)
end

def set_fake_mode_on
  fake_mode_switch = elem_of_class(TYPE_SWITCH, name: STR_ADD_FAKE_POEMS)
  fake_mode_switch.click
end

def navigation_bar_of_name(name)
  elem_of_class('XCUIElementTypeNavigationBar', name: name)
end

def set_singer_inaba_kun
  wheel = find_element(class_name: TYPE_PICKER_WHEEL)
  wheel.send_keys STR_INABA_KUN
  click_back_button
  can_see STR_INABA_KUN
end

def set_recite_mode_beginner
  click_element_with_text('読み上げモード')
  can_see('読み上げモードを選ぶ')
  wheel = find_element(class_name: TYPE_PICKER_WHEEL)
  wheel.send_keys '初心者（散らし取り）'
  click_back_button
  can_see '初心者'
end

def set_recite_mode_nonstop
  click_element_with_text('読み上げモード')
  can_see('読み上げモードを選ぶ')
  wheel = find_element(class_name: TYPE_PICKER_WHEEL)
  wheel.send_keys 'ノンストップ（止まらない）'
  click_back_button
  can_see 'ノンストップ'
end

def sleep_while_animation
  sleep 0.5
end

def quit_settings_and_see(str)
  click_button(CLOSE_ON_GAME_SETTINGS)
  can_see str
end

def click_forward_button
  click_button('forward')
end

def click_rewind_button
  click_button('rewind')
end

def click_refrain_button
  click_button('refrain_button')
end

def click_torifuda_button
  click_button('torifuda_button')
end

def click_quit_button
  quit_button.click
end

def open_quit_dialogue
  click_quit_button
  can_see(DIALOGUE_MESSAGE_FOR_QUIT)
end

def click_back_button
  # click_button('戻る')
  ### NavigationControllerのbackItemが取得できなくなったので、最初に取得できるボタンがbackItemだと仮定する。
  ### もうちょっとマシな解決方法ああれば良いのだが…
  get_first_button.click
end

def click_settings_button
  sleep_while_animation
  settings_button.click
end

def click_element_with_text(text)
  click_element_of(TYPE_STATIC_TEXT, name: text)
end

def tap_first_poem
  click_element_of(TYPE_CELL, name: '001')
end

def click_button_to_cancel_all
  sleep_while_animation
  toolbar.find_element(:name, '全て取消').click
end

def click_button_to_select_all
  sleep_while_animation
  toolbar.find_element(:name, '全て選択').click
end

def goto_five_colors_screen
  sleep_while_animation
  toolbar.find_element(:name, STR_SELECT_BY_FIVE_COLORS).click
  # click_button(STR_SELECT_BY_FIVE_COLORS)
end

def select_blue_color
  click_button('blue_group_button')
end

def select_pink_color
  click_button('pink_group_button')
end


private

def first_text_elem
  find_elements(:xpath, '//' + TYPE_STATIC_TEXT).first
end

def click_button(name)
  click_element_of(TYPE_BUTTON, name: name)
end

def get_first_button
  puts "       (見つかったボタンの数: #{find_elements(class_name: TYPE_BUTTON).size})"
  # ↑ なぜか、このデバッグ用の一行を追加すると、正しく動作するようになった。訳が分からない。
  find_elements(class_name: TYPE_BUTTON).first
end

def first_text_content
  first_text_elem.name
end

def elem_of_class(class_name, name: nil)
  find_elements(:class_name, class_name).find{|c| c.name == name}
end

def click_element_of(class_name, name: nil)
  elem_of_class(class_name, name: name).click
end

def elems_of_str(text)
  find_elements(:accessibility_id, text)
end

def settings_button
  elem_of_class(TYPE_BUTTON, name: 'gear') ||
      elem_of_class(TYPE_BUTTON, name: 'gear_button')
end

def quit_button
  elem_of_class(TYPE_BUTTON, name: 'quit_button') ||
      elem_of_class(TYPE_BUTTON, name: 'exit')
end

def toolbar
  find_element(:class_name, 'XCUIElementTypeToolbar')
end