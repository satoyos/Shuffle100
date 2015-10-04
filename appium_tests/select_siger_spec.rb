# coding: utf-8
require_relative 'spec_helper'

describe '読手を選ぶテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '読手を選ぶと、それがホーム画面に反映される' do
    it '初期状態では、ボーカロイドが読手として選ばれている' do
      can_see('IA（ボーカロイド）')
    end

    it 'ホーム画面で読手セルをタップすると、読手を設定する画面が開く' do
      click_element_of('UIATableCell', name: '読手')
      can_see('読手を選ぶ')
    end

    it '「いなばくん」を選んで、ホーム画面に戻ると、それが読手として設定されている' do
      set_singer_inaba_kun
      can_not_see('IA（ボーカロイド）')
    end
  end
end
