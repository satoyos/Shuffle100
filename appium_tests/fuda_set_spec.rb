# coding: utf-8
require_relative 'spec_helper'

STR_ONE_POEM_AT_LIEAST = '歌を選びましょう'

describe '札セットを保存するテスト' do

  it 'アプリのタイトルが正しく表示される' do
    current_screen_is TOP_TITLE
  end

  describe '歌を選ぶ画面で選択中の歌のセットを、名前をつけて保存できる' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '歌選択画面に「保存」ボタンが表示されている' do
      can_see('保存')
    end
=begin
    it '「全て取消」を選ぶと、全く歌が選ばれていない状態になる' do
      click_button_to_cancel_all
      click_back_button
      can_see '0首'
      goto_select_poem_screen
    end
    it '「まとめて選ぶ」を選ぶと、選択方法が表示される' do
      select_by_group
      can_see STR_NGRAM_PICKER
      # can_see STR_SELECT_BY_FIVE_COLORS
    end
    it '「1字目で選ぶ」ボタンを押すことで、その画面に遷移する' do
      open_first_char_select_screen
    end
    it '「一字決まりの歌」のセルをタップすると、7首の歌が選ばれる' do
      select_one_char_kimari
      2.times{ click_back_button }
      can_see '7首'
    end
=end
  end
end
