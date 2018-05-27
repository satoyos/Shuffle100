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
  describe '読み上げ画面を撮る' do
    it '試合を開始し、早送りボタンを押して、1首めへ行くと、読み上げ予定枚数は2首になっている' do
      open_game
      click_forward_button
      recite_screen_title_matches /1首め/
    end
    it '少し待って、ポーズボタンを押し、スクリーンショットを撮る' do
      sleep 3.0
      click_button'pause'
      take_screenshot_no(1)
    end
    it 'ホーム画面に戻る' do
      click_quit_button
      alert_dismiss
      sleep_while_animation
      current_screen_is TOP_TITLE
    end
  end

  describe '取り札画面を撮る' do
    it '初心者モードにする' do
      can_see(STR_ADD_FAKE_POEMS)
      set_recite_mode_beginner
      can_not_see(STR_ADD_FAKE_POEMS)
    end

    it '試合を開始し、早送りボタンを押して、1首めへ' do
      open_game
      click_forward_button
      recite_screen_title_matches(/\A1首め/)
    end

    it 'さらに早送りボタンを押して、下の句へ。' do
      click_forward_button
      recite_screen_title_matches /下の句/
    end

    it 'もう一度早送りボタンを押すと、「次はどうする？」画面になる' do
      click_forward_button
      sleep 1
      current_screen_is WHATS_NEXT_STR
    end
    it '「取り札を見る」ボタンを押すと、取り札画面が表示される' do
      click_torifuda_button
      can_see('torifuda_view')
    end
    it 'ここでスクリーンショットを撮る' do
      sleep_while_animation
      take_screenshot_no(4)
    end
    it 'ホーム画面に戻る' do
      close_whats_next_screen
      click_quit_button
      alert_dismiss
      sleep 2.0
      current_screen_is TOP_TITLE
    end
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
      sleep_while_animation
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

  describe '歌検索画面を撮る' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '検索窓に「秋」を入力する' do
      fill_search_window_with_text '春'
      make_test_success
    end
    it 'ここでスクリーンショットを撮る' do
      take_screenshot_no(3)
    end
    it 'ホーム画面に戻る' do
      click_button('キャンセル')
      click_back_button
      current_screen_is TOP_TITLE
    end
  end

  describe '「歌を選ぶ」画面を撮る' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '「全て取消」を選ぶと、全く歌が選ばれていない状態になる' do
      click_button_to_cancel_all
      make_test_success
    end
    it '3番目の歌を選ぶ' do
      select_poem_of_no(3)
    end
    it '5番目の歌を選ぶ' do
      select_poem_of_no(5)
    end
    it '7番目の歌を選ぶ' do
      select_poem_of_no(7)
    end
    it 'スクロールする' do
      scroll_screen(150)
    end
    it '8番目の歌を選ぶ' do
      select_poem_of_no(8)
    end
    it '11番目の歌を選ぶ' do
      if @device_name =~ /iPhone X/ or @device_name =~ /iPad/ or @device_name =~ /Plus/
        select_poem_of_no(11)
      end
    end
    it 'ここでスクリーンショットを撮る' do
      take_screenshot_no(2)
      make_test_success
    end
    it 'ホーム画面に戻る' do
      click_back_button
      current_screen_is TOP_TITLE
    end
  end

end

def select_poem_of_no(num)
  poem_cells[num-1].click
  make_test_success
end

def poem_cells
  @cells ||= find_elements(:class_name, TYPE_CELL)
end

def select_poem_of_numbers(numbers)
  numbers.each { |num|
    poem_cells[num-1].click
    swipe()
  }
end

def scroll_screen(scroll_up_length)
  puts "↑↑ #{scroll_up_length}だけ上にスクロールします"
  startX = 100
  startY = 250
  Appium::TouchAction.new.swipe(
      start_x: startX,
      start_y: startY,
      end_x: startX,
      end_y: startY-scroll_up_length,
      duration: 1000).perform
  make_test_success
end
