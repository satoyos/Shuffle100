# coding: utf-8
require_relative 'spec_helper'

STR_ONE_POEM_AT_LIEAST = '歌を選びましょう'
STR_SAVE_FUDA_SET = '保存'
STR_CONFIRM_SAVE_METHOD = '選択している札のセットをどう保存しますか？'
STR_SAVE_AS_NEW_SET = '新しい札セットとして保存する'
STR_CANCEL = 'キャンセル'


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
      can_see(STR_SAVE_FUDA_SET)
    end
    it '「保存」をタップすると、どのように保存するかをユーザに確認するダイアログが現れる' do
      click_save_button
      can_see STR_CONFIRM_SAVE_METHOD
    end
    it 'そのダイアログでキャンセルボタンを押すと、ダイアログが消える' do
      click_cancel_button
      sleep_while_animation
      can_not_see STR_CONFIRM_SAVE_METHOD
    end
=begin
    it '「新しい札セット」の方を選ぶと、新しいセットの名前を入力する多面が現れる' do
      click_new_set_button
      can_see '新しい札セットの名前を決めてください'
    end
=end

=begin
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

def click_save_button
  click_button(STR_SAVE_FUDA_SET)
end

def click_new_set_button
  sleep_while_animation
  click_button(STR_SAVE_AS_NEW_SET)
end

def click_cancel_button
  sleep_while_animation
  click_button(STR_CANCEL)
end

def sleep_while_animation
  sleep 0.5
end