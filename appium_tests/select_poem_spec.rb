# coding: utf-8
require_relative 'spec_helper'

describe '歌を選ぶテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '「1文字めで選ぶ」が正しく機能する' do
    it '歌選択画面を開く' do
      open_select_poem_screen
    end
    it '「全て取消」を選ぶと、全く歌が選ばれていない状態になる' do
      click_all_clear_button
      click_back_button
      can_see '0首'
      open_select_poem_screen
    end
    it '「1字目で選ぶ」ボタンを押すことで、その画面に遷移する' do
      open_first_char_select_screen
    end
    it '「一字決まりの歌」のセルをタップすると、7首の歌が選ばれる' do
      click_element_with_text('一字決まりの歌')
      2.times{ click_back_button }
      can_see '7首'
    end
  end

  describe '1首も歌が選ばれていない状態で試合を開始すると、警告を出す' do
    it '歌選択画面を開き、全く歌が選ばれていない状態にする' do
      open_select_poem_screen
      click_all_clear_button
      click_back_button
      can_see '0首'
    end
    it 'この状態で試合を開始すると、警告(AlertView)が表示される' do
      open_game_without_check
      can_see '歌を選びましょう'
      click_button('戻る')
    end
  end
end

private

def open_select_poem_screen
  click_element_with_text('取り札を用意する歌')
  can_see('歌を選ぶ')
end

def open_first_char_select_screen
  click_button('1字目で選ぶ')
  can_see '一字決まりの歌'
end

def click_all_clear_button
  click_button('全て取消')
end