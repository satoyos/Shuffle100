# coding: utf-8
require_relative 'spec_helper'

describe '初心者モードのテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '「次はどうする？」画面での動作確認' do

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
      current_screen_is WHATS_NEXT_STR
    end

    it '「下の句をもう一度読む」ボタンを押すと、下の句の読み上げを繰り返す' do
      click_refrain_button
      recite_screen_title_matches /\A1首め/
      click_forward_button # 早送りして、また「次はどうする？」画面に戻る
    end

    it '「取り札を見る」ボタンを押すと、取り札画面が表示される' do
      click_torifuda_button
      can_see('torifuda_view')
      sleep 1
      close_whats_next_screen # 取り札画面を閉じて、また「次はどうする？」画面に戻る
    end
  end
end

describe '他のモードで空札をonにした後でも、初心者モードで起動すると、空札設定はoffになる' do
  it '空札を加えるモードにする' do
    set_fake_mode_on
  end

  it '歌選択画面を開く' do
    goto_select_poem_screen
    current_screen_is POEM_SELECTION_TITLE
  end

  it '1首だけ選ぶと、トップ画面に戻っても、1首選ばれていることが反映されている' do
    click_button_to_cancel_all
    tap_first_poem
    click_back_button
    current_screen_is TOP_TITLE
    can_see '1首'
  end
  it '試合を開始し、早送りボタンを押して、1首めへ行くと、読み上げ予定枚数は2首になっている' do
    open_game
    click_forward_button
    recite_screen_title_matches /全2首/
  end
  it 'そこで試合を終了し、トップに戻る' do
    open_quit_dialogue
    alert_dismiss
    current_screen_is TOP_TITLE
  end
  it '初心者モードにすると、「空札を加える」を選択するセルが無くなる' do
    can_see(STR_ADD_FAKE_POEMS)
    set_recite_mode_beginner
    can_not_see(STR_ADD_FAKE_POEMS)
  end

  it '試合を開始し、早送りボタンを押して、1首めへ' do
    open_game
    click_forward_button
    recite_screen_title_matches /\A1首め/
  end
  it '初心者モードなので、読み上げ予定枚数は1枚に減っている。' do
    recite_screen_title_matches /全1首/
  end

end
