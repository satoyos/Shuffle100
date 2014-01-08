describe 'RecitePoemController' do
  describe '初期化' do
    tests RecitePoemController

    it 'should be a valid controller' do
      controller.should.not.be.nil
      controller.is_a?(RecitePoemController).should.be.true
    end

    it 'プロパティとしてdeckを持つ' do
      controller.deck.should.not.be.nil
    end

    it 'プロパティとしてplayersを持つ' do
      controller.players.should.not.be.nil
    end
  end

  describe '最初は序歌を読み上げる' do
    tests RecitePoemController

    it '最初に読み上げ画面が開いたときには、「序歌」がタイトルに設定されている' do
      controller.title.should == '序歌'
    end

    it 'まず、序歌が読み上げられている' do
      opening_player.should.not.be.nil
      opening_player.playing?.should.be.true
    end

    it 'playボタンを押すと、読み上げが止まったり再開したりする' do
      opening_player.playing?.should.be.true
      #noinspection RubyArgCount
      tap 'play_button'
      opening_player.playing?.should.be.false
      #noinspection RubyArgCount
      tap 'play_button'
      opening_player.playing?.should.be.true
    end
  end
end

def opening_player
  UIApplication.sharedApplication.delegate.opening_player
end