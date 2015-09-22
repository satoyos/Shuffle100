# coding: utf-8
require_relative 'spec_helper'

describe "試合終了テスト" do
  it "アプリのタイトルが正しく表示される" do
    can_see(TITLE)
  end

  it '試合開始' do
    open_game
  end

  DIALOGUE_MESSAGE = '試合を終了しますか？'

  it 'quitボタンを押すと、ダイアログが開く' do
    open_quit_dialogue
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
    open_quit_dialogue
  end

  it '「続ける」を押すと、ゲーム再開' do
    alert_accept
    can_not_see(TITLE)
    can_see(JOKA)
  end
  
end

private

def open_quit_dialogue
    click_element_of('UIAButton', name: 'quit_button')
    can_see(DIALOGUE_MESSAGE)
end
