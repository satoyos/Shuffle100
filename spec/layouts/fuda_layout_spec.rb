describe 'FudaLayout' do
  describe '初期化' do
    before do
      @layout = FudaLayout.new
    end
    it 'should be a valid layout' do
      @layout.should.not.be.nil
      @layout.should.be.kind_of MK::Layout
    end
    it '背景色は白' do
      @layout.view.backgroundColor.should == FudaLayout::BASE_BACK_COLOR
    end
  end
end