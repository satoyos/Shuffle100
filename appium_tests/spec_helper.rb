require "rubygems"
require "appium_lib"

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
    @driver.manage.timeouts.implicit_wait = 5
    Appium.promote_appium_methods Object
  }

  c.after(:all) {
    @driver.quit
  }
}

module StringWithUTF8Mac
  def ==(other)
    self.encode('UTF-8', 'UTF-8-Mac').eql? other.encode('UTF-8', 'UTF-8-Mac')
  end
end

class String
  prepend StringWithUTF8Mac
end
