# coding: utf-8
require_relative 'spec_helper'


describe '初心者モードのテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '「次はどうする？」画面での動作確認' do

    it '初心者モードにする' do
      can_see('空札を加える')
      set_recite_mode_beginner
      can_not_see('空札を加える')
    end

    it '試合を開始し、早送りボタンを押して、1首めへ' do
      open_game
      click_button('forward')
      expect(first_text_elem.value).to match_regex /\A1首め/
    end

    it 'さらに早送りボタンを押して、下の句へ。' do
      click_button('forward')
      expect(first_text_elem.value).to match_regex /下の句/
    end

=begin
    it 'もう一度早送りボタンを押すと、「次はどうする？」画面になる' do
      button('forward').click
      expect(first_text_elem.value).to eq WHATS_NEXT_STR
    end

    it '「下の句をもう一度読む」ボタンを押すと、下の句の読み上げを繰り返す' do
      button('refrain_button').click
      expect(first_text_elem.value).to match_regex /\A1首め/
      button('forward').click # 早送りして、また「次はどうする？」画面に戻る
    end

    it '「取り札を見る」ボタンを押すと、取り札画面が表示される' do
      button('torifuda_button').click
      can_see('torifuda_view')
      button('閉じる').click # 取り札画面を閉じて、また「次はどうする？」画面に戻る
    end
=end
  end
end

=begin
describe '他のモードで空札をonにした後でも、初心者モードで起動すると、空札設定はoffになる' do
  it '空札を加えるモードにする' do
    set_fake_mode_on
  end
  it '歌選択画面を開く' do
    click_element_of('UIATableCell', name: '取り札を用意する歌')
    can_see('歌を選ぶ')
  end
  it '「全て取消」を選ぶと、全く歌が選ばれていない状態になる' do
    button('全て取消').click
    can_see '0首'
  end
  it '一首目のセルをタップすると、選択した歌の数が1になる' do
    click_element_of('UIATableCell', name: '001')
    can_see '1首'
  end
  it 'トップ画面に戻っても、1首選ばれていることが反映されている' do
    back
    can_see 'トップ'
    can_see '1首'
  end
  it '試合を開始し、早送りボタンを押して、1首めへ行くと、読み上げ予定枚数は2首になっている' do
    open_game
    button('forward').click
    expect(first_text_elem.value).to match_regex /全2首/
  end
  it 'そこで試合を終了し、トップに戻る' do
    open_quit_dialogue('quit_button')
    alert_dismiss
    can_see(TITLE)
  end
  it '初心者モードにする' do
    can_see('空札を加える')
    set_recite_mode_beginner
    can_not_see('空札を加える')
  end

  it '試合を開始し、早送りボタンを押して、1首めへ' do
    open_game
    button('forward').click
    expect(first_text_elem.value).to match_regex /\A1首め/
  end
  it '初心者モードなので、読み上げ予定枚数は1枚に減っている。' do
    expect(first_text_elem.value).to match_regex /全1首/
  end

end
=end
