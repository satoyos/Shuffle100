require_relative 'string_with_utf8_mac'


def elem_of_class(class_name, name: nil)
  find_elements(:class_name, class_name).find{|c| c.name == name}
end

def click_element_of(class_name, name: nil)
  elem_of_class(class_name, name: name).click
end

def elems_of_str(text)
  find_elements(:accessibility_id, text)
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

def open_quit_dialogue(label)
  click_button(label)
  can_see(DIALOGUE_MESSAGE_FOR_QUIT)
end

def click_element_with_text(text)
  click_element_of('XCUIElementTypeStaticText', name: text)
end

def click_button(name)
  click_element_of('XCUIElementTypeButton', name: name)
end

def click_back_button
  click_button('戻る')
end
