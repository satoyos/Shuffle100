describe 'RecitePoemLayout' do
  describe '初期化' do
    before do
      @layout = RecitePoemLayout.new(root: test_view).build
    end

    it 'should not be nil' do
      @layout.should.not.be.nil
    end

    it '背景色は白' do
      @layout.get(:rp_view).backgroundColor.should == UIColor.whiteColor
    end


    def test_view
      UIView.alloc.initWithFrame(CGRectMake(0, 0, 360, 568))
    end
  end

end