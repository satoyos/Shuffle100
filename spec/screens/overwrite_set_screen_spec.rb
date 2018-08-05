describe 'OverwriteSetScreen' do
  tests OverwriteSetScreen
  alias :screen :controller

  describe '初期化' do
    it 'should be a valid screen' do
      screen.should.not.be.nil
      screen.is_a?(PM::Screen).should.be.true
    end
    it 'Viewが正しく設定されている' do
      screen.view.backgroundColor.should == UIColor.whiteColor
    end
    it 'Safe Areaが取得できる' do
      screen.view.safeAreaInsets.tap do |insets|
        insets.should.not.be.nil
        insets.is_a?(UIEdgeInsets).should.be.true
        puts "Insets => bottom: #{insets.bottom}, left: #{insets.left}, top: #{insets.top}"
      end

    end
  end
end