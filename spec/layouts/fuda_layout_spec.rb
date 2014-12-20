describe 'FudaLayout' do
  describe '初期化' do
    before do
      @layout = FudaLayout.new
    end
    it 'should be a valid layout' do
      @layout.should.not.be.nil
      @layout.should.be.kind_of MK::Layout
    end
    it '背景色は指定色' do
      @layout.view.backgroundColor.should == FudaLayout::BASE_BACK_COLOR
    end
  end

  describe 'クラスメソッドcrate_with_frame:str:' do
    TEST_STR = 'のもりはみすやきみかそてふる'
    TEST_FRAME = CGRectMake(0, 0, 320, 480)
    before do
      @layout = FudaLayout.create_with_frame(TEST_FRAME, str: TEST_STR)
    end
    it 'should be a valid layout' do
      @layout.should.be.kind_of MK::Layout
    end
    it 'パラメータで与えたデータがインスタンスに設定されている' do
      @layout.view_frame.should.eql TEST_FRAME
      @layout.shimo_str.should.eql TEST_STR
    end
  end
end