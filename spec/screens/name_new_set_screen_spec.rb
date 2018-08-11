describe 'NameNewSetScreen' do
  tests NameNewSetScreen
  alias :screen :controller

  describe '初期化' do
    it 'should be a valid screen' do
      screen.should.not.be.nil
      screen.is_a?(PM::Screen).should.be.true
    end
    it 'Viewが正しく設定されている' do
      screen.view.backgroundColor.should == UIColor.whiteColor
    end
    it 'should not rotate' do
      screen.should_autorotate.should.be.false
    end
  end
end