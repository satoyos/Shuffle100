# coding: utf-8
require_relative 'spec_helper'


describe "試合終了テスト" do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '歌読み上げ画面からの試合終了' do
    it '試合開始' do
      open_game
    end

    it 'quitボタンを押すと、ダイアログが開く' do
      open_quit_dialogue
    end

    it '「終了する」を押すと、トップ画面に戻る' do
      alert_dismiss
      current_screen_is TOP_TITLE
    end

    it 'もういちど試合再開' do
      open_game
    end

    it 'quitボタンを押すと、ダイアログが開く' do
      open_quit_dialogue
    end

    it '「続ける」を押すと、ゲーム再開' do
      alert_accept
      can_not_see(TOP_TITLE)
      recite_screen_title_matches Regexp.new(JOKA)
    end

    it 'ふたたび試合を抜ける' do
      open_quit_dialogue
      alert_dismiss
    end
  end

  describe '「次はどうする？」画面からのゲーム終了テスト' do
    it '初心者モードをonにする' do
      can_see('空札を加える')
      set_recite_mode_beginner
      can_not_see('空札を加える')
    end

    it '試合を開始し、早送りボタンを押して、1首めへ' do
      open_game
      click_forward_button
      recite_screen_title_matches /\A1首め/
    end

    it 'さらに早送りボタンを押して、下の句へ。' do
      click_forward_button
      recite_screen_title_matches /下の句/
    end

    it 'もう一度早送りボタンを押すと、「次はどうする？」画面になる' do
      click_forward_button
      current_screen_is WHATS_NEXT_STR
    end

    it 'quitボタンを押すと、ダイアログが開く' do
      sleep 1
      open_quit_dialogue
    end

    it '「終了する」を押すと、トップ画面に戻る' do
      alert_dismiss
      can_not_see(JOKA)
      current_screen_is TOP_TITLE
    end
  end
end
