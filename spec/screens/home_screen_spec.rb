describe 'HomeScreen' do
  tests HomeScreen

  def controller
    @controller ||= HomeScreen.new
  end
  alias :screen :controller

  it 'is a TableScreen' do
    screen.should.be.kind_of PM::GroupedTableScreen
  end

  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end

  it 'delegateにアクセスできる' do
    screen.app_delegate.should.not.be.nil
  end
end