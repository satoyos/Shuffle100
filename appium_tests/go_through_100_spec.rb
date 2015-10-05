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

describe '初心者モードで、百首を通して(問題を起こさず)読み上げられる' do
  it '読手を「いなばくん」に変更' do
    set_singer_inaba_kun
  end
  it '初心者モードをonにする' do
    set_beginner_mode_on
  end
  it '試合を開始し、早送りボタンを押して、1首めへ' do
    open_game
    button('forward').click # 序歌画面をスキップ
    expect(first_text_elem.value).to match_regex /\A1首め/
  end
  it '残り、百首まで問題無く読み上げられる' do
    (2..100).each { |i|
      skip_skip_next
      expect(first_text_elem.value).to match_regex Regexp.new("\\A#{i}首め")
    }
  end
  it '百首めが終わると、試合終了画面が表示される' do
    skip_skip_next
    can_see '試合終了'
  end
end

private

def skip_start_skip
  button('forward').click # 上の句の終わりまで
  button('play').click # 下の句から読み上げ再開
  button('forward').click # 読み上げをスキップ
end

def skip_skip_next
  button('forward').click    # 上の句の終わりまで
  button('forward').click    # 下の句の終わりまで
  button('next_poem_button').click # 次の歌に進む
end