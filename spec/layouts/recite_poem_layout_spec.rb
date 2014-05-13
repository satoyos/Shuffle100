describe 'RecitePoemLayout' do
  describe '初期化' do
    before do
      @layout = RecitePoemLayout.new
    end

    it 'should not be nil' do
      @layout.should.not.be.nil
    end

    it '背景色は白' do
      @layout.view.backgroundColor.should == UIColor.whiteColor
    end
  end
end