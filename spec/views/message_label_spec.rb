describe 'MessageLabel' do
  describe '初期化' do
    before do
      @label = MessageLabel.alloc.initWithFrame([[0, 0], [360, 480]])
    end

    it 'should be a valid object' do
      @label.should.not.be.nil
    end
  end

  describe 'drawTextInRect' do
    before do
      @label = MessageLabel.alloc.initWithFrame([[0, 0], [360, 480]])
      @label.text = 'test'
    end

    it 'メソッドが正常に実行できる' do
      @label.drawTextInRect(@label.bounds)
      1.should == 1
    end
  end
end