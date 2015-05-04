describe 'SelectSingerScreen' do
  describe '初期化' do

    def controller
      @controller ||= SelectSingerScreen.new
    end
    alias :screen :controller

    it 'should not be nil' do
      screen.should.not.be.nil
    end

    it 'has a view of white background' do
      screen.view.backgroundColor.should == UIColor.whiteColor
    end
    it 'タイトルが設定されている' do
      screen.title.should == '読手を選ぶ'
    end
    it '読み手データを正しく読み込んでいる' do
      screen.singers.size.should == Singer::SINGERS_DATA.size
      screen.singers.first.is_a?(Singer).should.be.true
    end

  end
end

