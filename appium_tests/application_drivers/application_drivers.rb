require_relative 'string_with_utf8_mac'


def  first_text_is(str)
  expect(first_text_content).to eq str
end

def currnet_screen_is(name)
  expect(navigation_bar_of_name(name)).not_to be nil
end

def recite_screen_title_matches(regexp)
  # 読み上げ画面のヘッダのラベルにacccessibilityLabelを設定すると、
  # Appium Test上では、そのラベルのaccessibility_idだけでなく、labelやnameもすべてその値に書き換わり、
  # 実際にどのような文字列が書かれているのかが取得できなくなる。
  # なので、不本意ながら、「最初に取得できるテキストラベル」を「読み上げ画面のヘッダラベル」とみなす。
  expect(first_text_content).to match_regex regexp
end


def can_see(text)
  expect(elems_of_str(text)).not_to be_empty
end

def can_not_see(text)
  expect(elems_of_str(text)).to be_empty
end

def open_game
  open_game_without_check
  can_see(JOKA)
end

def open_game_without_check
  click_element_with_text('試合開始')
end

def first_text_elem
  find_elements(:xpath, '//XCUIElementTypeStaticText').first
end

def set_fake_mode_on
  fake_mode_switch = elem_of_class('XCUIElementTypeSwitch', name: '空札を加える')
  fake_mode_switch.click

end

def navigation_bar_of_name(name)
  elem_of_class('XCUIElementTypeNavigationBar', name: name)
end

def set_singer_inaba_kun
  wheel = find_element(class_name: 'UIAPickerWheel')
  wheel.send_keys 'いなばくん（人間）'
  click_back_button
  can_see 'いなばくん（人間）'
end

def set_recite_mode_beginner
  click_element_with_text('読み上げモード')
  can_see('読み上げモードを選ぶ')
  wheel = find_element(class_name: 'UIAPickerWheel')
  wheel.send_keys '初心者（散らし取り）'
  click_back_button
  can_see '初心者'
end

def set_recite_mode_nonstop
  click_element_with_text('読み上げモード')
  can_see('読み上げモードを選ぶ')
  wheel = find_element(class_name: 'UIAPickerWheel')
  wheel.send_keys 'ノンストップ（止まらない）'
  click_back_button
  can_see 'ノンストップ'
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

def open_quit_dialogue(label)
  click_button(label)
  can_see(DIALOGUE_MESSAGE_FOR_QUIT)
end

def click_back_button
  # click_button('戻る')
  ### NavigationControllerのbackItemが取得できなくなったので、最初に取得できるボタンがbackItemだと仮定する。
  ### もうちょっとマシな解決方法ああれば良いのだが…
  get_first_button.click
end

def click_element_with_text(text)
  click_element_of('XCUIElementTypeStaticText', name: text)
end

def go_to_poem_selection
  click_element_with_text('取り札を用意する歌')
end

def tap_first_poem
  click_element_of('XCUIElementTypeCell', name: '001')
end

def click_button_to_cancel_all
  click_button('全て取消')
end



private

def click_button(name)
  click_element_of('XCUIElementTypeButton', name: name)
end

def get_first_button
  find_elements(class_name: 'XCUIElementTypeButton').first
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

