# coding: utf-8
require "rubygems"
require "appium_lib"
require_relative 'application_drivers/application_drivers'

TITLE = '百首読み上げ'
JOKA  = '序歌'
WHATS_NEXT_STR = '次はどうする？'
DIALOGUE_MESSAGE_FOR_QUIT = '試合を終了しますか？'
TOP_TITLE = 'トップ'
POEM_SELECTION_TITLE = '歌を選ぶ'
ROOT = "."

def desired_caps
  {
      caps: {
          platformName:  "iOS",
          deviceName:    "iPhone X",
          # deviceName:    "iPhone 7",
          # deviceName:    "iPad Pro (10.5-inch)",
          platformVersion: "11.3",
          # platformVersion: "10.3",
          app: '../build/iPhoneSimulator-10.0-Development/Shuffle100.app',
          # fullReset: true,  # Appium1.5+(試したのは1.5.3)で、シミュレータの2回起動を抑止する。
          automationName: 'XCUITest'
      },
      appium_lib: {
          wait: 10
      }
  }
end

RSpec.configure { |c|
  c.before(:all) {
    @driver = Appium::Driver.new(desired_caps, true).start_driver
    @driver.manage.timeouts.implicit_wait = 2
    Appium.promote_appium_methods Object

  }

  c.before(:each) do |example|
    @recorder = Recorder.new(@driver)
    @recorder.start("#{ROOT}/screenshots/#{example.description}.mov")
  end

  c.after(:each) { |example|
    if @recorder
      @recorder.stop

      # テストが通った場合は録画を消す（=失敗したものは残る）
      @recorder.remove_video unless example.exception
    end
  }

  c.after(:all) {
    @driver.quit
  }
}
