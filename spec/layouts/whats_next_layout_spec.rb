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
=begin
    it '「下の句をもう一度詠む」ボタンがある' do
      #%ToDo: ここを書くところから！
    end
=end
  end
end