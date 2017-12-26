describe 'FiveColrosScreen' do
  tests FiveColorsScreen

  def controller
    @controller ||= FiveColorsScreen.new
  end
  alias :screen :controller

  it 'is a kind of PM::Screen' do
    screen.should.be.kind_of PM::Screen
  end
  it 'タイトルが正しく設定されている' do
    screen.title.should == '五色百人一首'
  end
  it '背景の色が正しく設定されている' do
    screen.view.backgroundColor.should == UIColor.whiteColor
  end
  it 'Layoutが設定されている' do
    screen.layout.should.not.be.nil
  end
end