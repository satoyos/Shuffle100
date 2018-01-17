# coding: utf-8
require_relative 'spec_helper'

STR_ONE_POEM_AT_LIEAST = '歌を選びましょう'

describe '歌を選ぶテスト' do

  it 'アプリのタイトルが正しく表示される' do
    current_screen_is TOP_TITLE
  end

  describe '「1文字めで選ぶ」が正しく機能する' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '「全て取消」を選ぶと、全く歌が選ばれていない状態になる' do
      click_button_to_cancel_all
      click_back_button
      can_see '0首'
      goto_select_poem_screen
    end
    it '「1字目で選ぶ」ボタンを押すことで、その画面に遷移する' do
      open_first_char_select_screen
    end
    it '「一字決まりの歌」のセルをタップすると、7首の歌が選ばれる' do
      select_one_char_kimari
      2.times{ click_back_button }
      can_see '7首'
    end
  end

  describe '1首も歌が選ばれていない状態で試合を開始すると、警告を出す' do
    it '歌選択画面を開き、全く歌が選ばれていない状態にする' do
      goto_select_poem_screen
      click_button_to_cancel_all
      click_back_button
      can_see '0首'
    end
    it 'この状態で試合を開始すると、警告(AlertView)が表示される' do
      open_game_without_check
      can_see STR_ONE_POEM_AT_LIEAST
    end
    it '警告を消す' do
      alert_accept
      can_not_see STR_ONE_POEM_AT_LIEAST
    end
  end


  describe '五色百人一首の色別の20首を選択できる' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '「全て選択」を押すと、100酒が選ばれた状態になる' do
      click_button_to_select_all
      click_back_button
      can_see '100首'
      goto_select_poem_screen
    end
    it '「五色」ボタンを押すことで、五色による歌選択画面に遷移する' do

      goto_five_colors_screen
      can_see "五色百人一首"
    end
    it '「青」ボタンを押すと、アクション選択ダイアログが表示される' do
      click_button('blue_group_button')
      can_see 'この20首だけを選ぶ'
    end
    it '「キャンセル」を押して、一旦戻る' do
      click_button('キャンセル')
      click_back_button
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it 'また五色百人一首の画面に戻る' do
      goto_five_colors_screen
      current_screen_is STR_FIVE_COLORS_SCREEN
    end
    it '「ピンク」ボタンを押すと、アクション選択ダイアログが表示される' do
      click_button('pink_group_button')
      can_see 'この20首だけを選ぶ'
    end
    it '「この20首だけを選ぶ」を押すと、選択されている歌の数が20首になる' do
      click_button('この20首だけを選ぶ')
      2.times { click_back_button}
      can_see '20首'
    end
    it '「五色」画面で青ボタンを押し、「今選んでいる札に加える」を選ぶ' do
      goto_select_poem_screen
      goto_five_colors_screen
      click_button('blue_group_button')
      click_button('今選んでいる札に加える')

    end
    it '40首が選ばれている状態になっている' do
      2.times { click_back_button}
      can_see '40首'
    end
  end
end

