# coding: utf-8
require_relative 'spec_helper'

describe '百首を通しで読み上げるテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '通常モードで、百首を通して(問題を起こさず)読み上げられる' do
    it '試合を開始し、早送りボタンを押して、1首めへ' do
      open_game
      click_forward_button # 序歌画面をスキップ
      expect(first_text_elem.value).to match_regex /\A1首め/
    end
    it '残り、百首まで問題無く読み上げる' do
      (2..100).each { |i|
        skip_start_skip
        expect(first_text_elem.value).to match_regex Regexp.new("\\A#{i}首め")
        puts "  -#{i}首目を読み上げ中。"
        puts '     [現在、通常モード]' if i % 10 == 1
      }
      # expect(1).to eq 1
    end
    it '百首めが終わると、試合終了画面が表示される' do
      skip_start_skip
      can_see '試合終了'
    end
    it '「トップに戻る」ボタンを押すと、トップ画面に戻る' do
      click_button('back_to_top')
      can_see(TITLE)
    end
  end
end

describe '初心者モードで、百首を通して(問題を起こさず)読み上げられる' do
  it 'ホーム画面で読手セルをタップすると、読手を設定する画面が開く' do
    click_element_with_text( '読手')
    can_see('読手を選ぶ')
  end
  it '読手を「いなばくん」に変更' do
    set_singer_inaba_kun
  end
  it '初心者モードにする' do
    can_see('空札を加える')
    set_recite_mode_beginner
    can_not_see('空札を加える')
  end
  it '試合を開始し、早送りボタンを押して、1首めへ' do
    open_game
    click_forward_button
    expect(first_text_elem.value).to match_regex /\A1首め/
    # expect(1).to eq 1
  end
  it '残り、百首まで問題無く読み上げられる' do
    (2..100).each { |i|
      skip_skip_next
      # 通常モードと同様の理由により、↓この確認は諦める。
      expect(first_text_elem.value).to match_regex Regexp.new("\\A#{i}首め")
      puts "  -#{i}首目を読み上げ中。"
      puts '     [現在、初心者モード]' if i % 10 == 1
    }
    # expect(1).to eq 1
  end
  it '百首めが終わると、試合終了画面が表示される' do
    skip_skip_next
    can_see '試合終了'
  end
end

=begin
describe 'ノンストップ・モードで、百首を通して(問題を起こさず)読み上げられる' do
  it 'ノンストップモードにする' do
    can_see('空札を加える')
    set_recite_mode_nostop
  end
  it '試合を開始し、早送りボタンを押して、1首めへ' do
    open_game
    click_forward_button
    expect(1).to eq 1
  end
  it '残り、百首まで問題無く読み上げられる' do
    (2..100).each { |i|
      skip_skip
      puts "  -#{i}首目を読み上げ中。"
    }
    expect(1).to eq 1
  end
  it '百首めが終わると、試合終了画面が表示される' do
    skip_skip
    can_see '試合終了'
  end
end
=end


private

def skip_start_skip
  click_forward_button
  click_button('play') # 下の句から読み上げ再開
  click_forward_button
end

def skip_skip_next
  click_forward_button
  click_forward_button
  click_button('next_poem_button') # 次の歌に進む
end

def skip_skip
  click_forward_button
  click_forward_button
end