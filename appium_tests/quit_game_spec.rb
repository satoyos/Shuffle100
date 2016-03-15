# coding: utf-8
require_relative 'spec_helper'


describe "試合終了テスト" do
  # DIALOGUE_MESSAGE_FOR_QUIT = '試合を終了しますか？'

  it "アプリのタイトルが正しく表示される" do
    can_see(TITLE)
  end

  describe '歌読み上げ画面からの試合終了' do
    it '試合開始' do
      open_game
    end

    it 'quitボタンを押すと、ダイアログが開く' do
      open_quit_dialogue('quit_button')
    end

    it '「終了する」を押すと、トップ画面に戻る' do
      alert_dismiss
      can_see(TITLE)
      can_not_see(JOKA)
    end

    it 'もういちど試合再開' do
      open_game
    end

    it 'quitボタンを押すと、ダイアログが開く' do
      open_quit_dialogue('quit_button')
    end

    it '「続ける」を押すと、ゲーム再開' do
      alert_accept
      can_not_see(TITLE)
      can_see(JOKA)
    end

    it 'ふたたび試合を抜ける' do
      open_quit_dialogue('quit_button')
      alert_dismiss
    end
  end

  describe '「次はどうする？」画面からのゲーム終了テスト' do
    it '初心者モードをonにする' do
      can_see('空札を加える')
      # click_element_of('UIATableCell', name: '読み上げモード')
      # can_see('読み上げモードを選ぶ')
      set_recite_mode_beginner
      can_not_see('空札を加える')
    end

    it '試合を開始し、早送りボタンを押して、1首めへ' do
      open_game
      button('forward').click
      expect(first_text_elem.value).to match_regex /\A1首め/
    end

    it 'さらに早送りボタンを押して、下の句へ。' do
      button('forward').click
      expect(first_text_elem.value).to match_regex /下の句/
    end

    it 'もう一度早送りボタンを押すと、「次はどうする？」画面になる' do
      button('forward').click
      expect(first_text_elem.value).to eq WHATS_NEXT_STR
    end

    it 'quitボタンを押すと、ダイアログが開く' do
      open_quit_dialogue('exit')
    end

    it '「終了する」を押すと、トップ画面に戻る' do
      alert_dismiss
      can_see(TITLE)
      can_not_see(JOKA)
    end
  end
end

=begin
private

def open_quit_dialogue(label)
    button(label).click
    can_see(DIALOGUE_MESSAGE_FOR_QUIT)
end
=end
