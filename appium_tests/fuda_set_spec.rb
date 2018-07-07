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
    it 'そのダイアログで「新しい札セット」の方を選ぶと、新しいセットの名前を入力する多面が現れる' do
      click_save_button
      sleep_while_animation
      click_new_set_button
      can_see '新しい札セットの名前'
    end
=begin
    it '新しい札セットの名前入力画面でキャンセルを押すと、札選択画面に戻る' do
      click_cancel_button
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it 'もう一度、命名画面を表示' do
      click_save_button
      sleep_while_animation
      click_new_set_button
      can_see '新しい札セットの名前'
    end
=end
    it '名前を入力し、「決定」を押すと、札セット一覧画面に繊維する' do
      fill_text_field_with '2字決まりセット'
      click_fix_button
      can_see '作った札セット'
    end
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

def click_fix_button
  sleep_while_animation
  click_button('決定')
end

def fill_text_field_with(str)
  find_element(:accessibility_id, 'name_field').send_keys str
end
