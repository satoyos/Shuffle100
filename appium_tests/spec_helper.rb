# coding: utf-8
require "rubygems"
require "appium_lib"
require_relative 'string_with_utf8_mac'

TITLE = '百首読み上げ'
JOKA  = '序歌'
WHATS_NEXT_STR = '次はどうする？'

def desired_caps
  {
      caps: {
          platformName:  "iOS",
          versionNumber: "9.2",
          deviceName:    "iPhone 5s",
          # deviceName:    "iPad Pro",
          app: '../build/iPhoneSimulator-9.0-Development/Shuffle100.app'
      },
      appium_lib: {
          wait: 10
      }
  }
end

RSpec.configure { |c|
  c.before(:all) {
    @driver = Appium::Driver.new(desired_caps).start_driver
    @driver.manage.timeouts.implicit_wait = 2
    Appium.promote_appium_methods Object
  }

  c.after(:all) {
    @driver.quit
  }
}

def elem_of_class(class_name, name: nil)
  find_elements(:class_name, class_name).find{|c| c.name == name}
end

def click_element_of(class_name, name: nil)
  # element = find_elements(:class_name, class_name).find{|c| c.name == name}
  elem_of_class(class_name, name: name).click
end

def elems_of_str(text)
  find_elements(:name, text)
end

def can_see(text)
  expect(elems_of_str(text)).not_to be_empty
end

def can_not_see(text)
  expect(elems_of_str(text)).to be_empty
end

def open_game
    click_element_of('UIATableCell', name: '試合開始')
    can_see(JOKA)
end

def first_text_elem
  find_elements(:xpath, '//UIAStaticText').first
end

=begin
def set_beginner_mode_on
  beginner_mode_switch = elem_of_class('UIASwitch', name: '初心者モード(散らし取り)')
  beginner_mode_switch.click if beginner_mode_switch.value == 0
  can_not_see('空札を加える')
end
=end

def set_singer_inaba_kun
  click_element_of('UIATableCell', name: '読手') if elems_of_str('試しに聞いてみる').empty?
  wheel = find_element(class_name: 'UIAPickerWheel')
  wheel.send_keys 'いなばくん（人間）'
  back
  can_see 'いなばくん（人間）'
end

def set_recite_mode_beginner
  click_element_of('UIATableCell', name: '読み上げモード')
  can_see('読み上げモードを選ぶ')
  wheel = find_element(class_name: 'UIAPickerWheel')
  wheel.send_keys '初心者（散らし取り）'
  back
  can_see '初心者'
end

def set_recite_mode_nostop
  click_element_of('UIATableCell', name: '読み上げモード')
  can_see('読み上げモードを選ぶ')
  wheel = find_element(class_name: 'UIAPickerWheel')
  wheel.send_keys 'ノンストップ（止まらない）'
  back
  can_see 'ノンストップ'
end


def click_forward_button
  button('forward').click
end
