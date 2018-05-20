# coding: utf-8
require_relative 'spec_helper'
require_relative 'application_drivers/screenshots'

describe 'スクリーンショットの撮影' do
  def make_test_success
    expect(1).to be 1
  end

  it 'アプリのタイトルが正しく表示される' do
    current_screen_is TOP_TITLE
  end
  describe '「歌と歌の間隔」設定画面を撮る' do

    it 'トップ画面で歯車ボタンを押すと、各種設定画面が現れる' do
      click_settings_button
      sleep_while_animation
      current_screen_is TITLE_FOR_ON_GAME_SETTINGS
    end
    it '「歌と歌の間隔」のセルを押すと、歌間隔設定画面に遷移する' do
      click_element_with_text(DURATION_BETWEEN_SONGS)
      current_screen_is TITLE_FOR_DURATION_BETWEEN_SONGS
    end
    it 'ここでスクリーンショットを撮る' do
      take_screenshot_no(5)
      make_test_success
    end
    it '設定を終了し、ホーム画面に戻る' do
      click_back_button
      sleep_while_animation
      click_back_button
      current_screen_is TOP_TITLE
    end
  end

  describe '「歌を選ぶ」画面を撮る' do

  end

end
