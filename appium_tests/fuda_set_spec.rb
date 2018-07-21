# coding: utf-8
require_relative 'spec_helper'

STR_ONE_POEM_AT_LIEAST = '歌を選びましょう'
STR_SAVE_FUDA_SET = '保存'
STR_CONFIRM_SAVE_METHOD = '選択している札のセットをどう保存しますか？'
STR_SAVE_AS_NEW_SET = '新しい札セットとして保存する'
STR_CANCEL = 'キャンセル'
STR_TEST_SET_NAME_2C = '2枚札のセット'
STR_NAME_NOT_DEFINED = '新しい札セットの名前を決めましょう'
STR_SAVE_COMPLETE = '保存完了'

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
=begin
    it '「保存」をタップすると、どのように保存するかをユーザに確認するダイアログが現れる' do
      click_save_button
      can_see STR_CONFIRM_SAVE_METHOD
    end
    it '確認ダイアログでキャンセルボタンを押すと、ダイアログが消える' do
      click_cancel_button
      sleep_while_animation
      can_not_see STR_CONFIRM_SAVE_METHOD
    end
    it '確認ダイアログで「新しい札セット」の方を選ぶと、新しいセットの名前を入力する多面が現れる' do
      click_save_button
      sleep_while_animation
      click_new_set_button
      can_see '新しい札セットの名前'
    end
    it '新しい札セットの名前入力画面でキャンセルを押すと、札選択画面に戻る' do
      click_cancel_button
      current_screen_is STR_SELECT_POEM_SCREEN
    end
=end
    it '2枚札だけを選択した状態にする' do
      click_button_to_cancel_all
      select_by_group
      open_first_char_select_screen
      click_element_of(TYPE_CELL, name: 'u')
      click_element_of(TYPE_CELL, name: 'tsu')
      click_element_of(TYPE_CELL, name: 'shi')
      click_element_of(TYPE_CELL, name: 'mo')
      click_element_of(TYPE_CELL, name: 'yu')
      click_back_button
    end
    it '命名画面を表示' do
      click_save_button
      sleep_while_animation
      click_new_set_button
      can_see '新しい札セットの名前'
    end
    it '名前を入力し、「決定」を押すと、「保存完了」ダイアログが表示される' do
      fill_name_field_with STR_TEST_SET_NAME_2C
      click_fix_button
      can_see STR_SAVE_COMPLETE
    end
    it 'ユーザの確認が終わると、ダイアログは消える' do
      alert_accept
      can_not_see STR_SAVE_COMPLETE
    end
    it 'メイン画面に戻ると、10首選ばれていることが客員できる' do
      click_back_button
      can_see '10首'
    end
    it '歌選択画面でNo.1の詩を選び、11首選択した状態にする' do
      goto_select_poem_screen
      click_element_of(TYPE_CELL, name: '001')
      click_back_button
      can_see '11首'
      goto_select_poem_screen
    end
    it '「まとめて選ぶ」を押すと、「作った札セットから選ぶ」アクションが表示されている' do
      select_by_group
      can_see STR_SELECT_FROM_FUDA_SETS
    end
    it '「作った札セットから選ぶ」をタップすると、札セット一覧画面に遷移する' do
      open_fuda_set_list_screen
    end
    it '「2毎札セット」を選ぶと、札選択画面に戻る' do
      sleep_while_animation
      click_element_with_text STR_TEST_SET_NAME_2C
      current_screen_is STR_SELECT_POEM_SCREEN
    end
=begin
    it '名前を入力し、「決定」を押すと、札セット一覧画面に繊維する' do
      fill_name_field_with STR_TEST_SET_NAME_2C
      click_fix_button
      current_screen_is '作った札セット'
    end
    it '作ったばかりの札セットが表示されている' do
      can_see STR_TEST_SET_NAME_2C
    end
    it '札選択画面に戻る' do
      click_back_button
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it 'もう一度、命名画面を表示' do
      click_save_button
      sleep_while_animation
      click_new_set_button
      can_see '新しい札セットの名前'
    end
    it '名前入力画面で名前を入力せずに「決定」を押すと、警告が出る' do
      fill_name_field_with ''
      click_fix_button
      can_see STR_NAME_NOT_DEFINED
    end
    it '警告を消す' do
      alert_accept
      can_not_see STR_NAME_NOT_DEFINED
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

def click_fix_button
  sleep_while_animation
  click_button('決定')
end

def fill_name_field_with(str)
  find_element(:accessibility_id, 'name_field').send_keys str
end
