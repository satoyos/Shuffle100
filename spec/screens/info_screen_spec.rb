describe 'InfoScreen' do
  tests InfoScreen

  def controller
    @controller ||= InfoScreen.new(url: 'html/options.html', title: 'aaa')
  end
  alias :screen :controller

  it 'should not be nil' do
    screen.should.not.be.nil
  end

  it '属性が正しく設定されている' do
    screen.title.should == 'aaa'
    screen.url.should == 'html/options.html'
  end
  it 'should be a PM::WebScreen' do
    screen.should.be.kind_of(PM::WebScreen)
  end

  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end
end