describe 'WhatsNextLayout' do
  describe '初期化' do
    before do
      @layout = WhatsNextLayout.new
    end

    it 'should not be nil' do
      @layout.should.not.be.nil
    end
    it 'is a kind of MotionKit::Layout' do
      @layout.should.be.kind_of MotionKit::Layout
    end
    it '「下の句をもう一度読む」ボタンがある' do
      @layout.get(:refrain_button).tap do |button|
        button.should.not.be.nil
        button.titleForState(UIControlStateNormal).should == '下の句をもう一度読む'
      end
    end
    it '「次の歌へ！」ボタンがある' do
      @layout.get(:next_poem_button).should.not.be.nil
    end
  end
end