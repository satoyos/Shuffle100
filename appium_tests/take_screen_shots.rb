# coding: utf-8
require_relative 'spec_helper'
require_relative 'application_drivers/screenshots'

describe 'スクリーンショットの撮影' do

  it 'アプリのタイトルが正しく表示される' do
    current_screen_is TOP_TITLE
  end
  it 'スクリーンショットを撮る' do
    take_screenshot_no(2)
  end

end
