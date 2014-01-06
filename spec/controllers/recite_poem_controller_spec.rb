describe 'RecitePoemController' do
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

=begin
  describe '初期化' do
    context 'initWithFrame:deck:で初期化' do
      before do
        @controller = RecitePoemController.alloc
        @controller.initWithDeck(Deck.new, players: [])
      end

      it 'should be a valid controller' do
        @controller.should.not.be.nil
      end

      it 'プロパティとしてdeckを持つ' do
        @controller.deck.should.not.be.nil
      end

      it 'プロパティとしてplayersを持つ' do
        @controller.players.should.not.be.nil
      end
    end
  end
=end

  describe '最初は序歌を読み上げる' do
    tests RecitePoemController

    it '最初に読み上げ画面が開いたときには、「序歌」がタイトルに設定されている' do
      controller.title.should == '序歌'
    end
  end
end