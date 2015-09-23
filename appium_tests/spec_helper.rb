# coding: utf-8
require "rubygems"
require "appium_lib"

TITLE = '百首読み上げ'
JOKA  = '序歌'

def desired_caps
  {
      caps: {
          platformName:  "iOS",
          versionNumber: "9.0",
          deviceName:    "iPhone 5s",
          app: '../build/iPhoneSimulator-8.0-Development/Shuffle100.app',
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


module StringWithUTF8Mac
  def ==(other)
    self.encode('UTF-8', 'UTF-8-Mac').eql? other.encode('UTF-8', 'UTF-8-Mac')
  end
end

class String
  prepend StringWithUTF8Mac
end
