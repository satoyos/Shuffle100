# coding: utf-8
require_relative 'spec_helper'

describe '百首を通しで読み上げるテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '通常モードで、百首を通して(問題を起こさず)読み上げられる' do
    it '試合を開始し、早送りボタンを押して、1首めへ' do
      open_game
      button('forward').click # 序歌画面をスキップ
      expect(first_text_elem.value).to match_regex /\A1首め/
    end
    it '残り、百首まで問題無く読み上げる' do
      (2..100).each { |i|
        skip_start_skip
        expect(first_text_elem.value).to match_regex Regexp.new("\\A#{i}首め")
      }
    end
    it '百首めが終わると、試合終了画面が表示される' do
      skip_start_skip
      can_see '試合終了'
    end
    it '「トップに戻る」ボタンを押すと、トップ画面に戻る' do
      button('back_to_top').click
      can_see(TITLE)
    end
  end
end

private

def skip_start_skip
  button('forward').click # 上の句の終わりまで
  button('play_button').click # 下の句から読み上げ再開
  button('forward').click # 読み上げをスキップ
end
