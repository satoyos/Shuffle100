# coding: utf-8
require_relative 'spec_helper'
require 'uri'

TITLE = '百首読み上げ'


def click_element_of(class_name, name: nil)
  element = find_elements(:class_name, class_name).find{|c| c.name == name}
  element.click
end

def can_see(text)
  expect(find_element(:name, text)).not_to be nil
end

def can_not_see(text)
  expect(find_element(:name, text)).to be nil
end

describe "試合終了テスト" do
  it "アプリのタイトルが正しく表示される" do
    title = find_element(:name, TITLE).text
    expect(title).to eq TITLE
  end

  it '試合開始' do
    click_element_of('UIATableCell', name: '試合開始')
    can_see('序歌')
  end

  DIALOGUE_MESSAGE = '試合を終了しますか？'

  it 'quitボタンを押すと、ダイアログが開く' do
    click_element_of('UIAButton', name: 'quit_button')
    can_see(DIALOGUE_MESSAGE)
  end

  it '「終了する」を押すと、トップ画面に戻る' do
    alert_dismiss
    can_see(TITLE)
  end
end


