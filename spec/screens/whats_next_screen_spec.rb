describe 'WhatsNextScreen' do
  tests WhatsNextScreen

  def controller
    @controller ||= WhatsNextScreen.new
  end
  alias :screen :controller

  it 'is a kind of PM::Screen' do
    screen.should.be.kind_of PM::Screen
  end
  it 'タイトルが正しく設定されている' do
    screen.title.should == '次はどうする？'
  end
  it 'Layoutが設定されている' do
    screen.layout.should.not.be.nil
  end
  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end
end