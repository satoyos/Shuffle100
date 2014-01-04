describe 'RecitePoemController' do

  it 'should be a valid controller' do
    tests RecitePoemController

    controller.should.not.be.nil
    controller.is_a?(RecitePoemController).should.be.true
  end

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
    end
  end
end