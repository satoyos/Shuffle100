describe 'HomeScreen' do
  tests HomeScreen

  def controller
    @controller ||= HomeScreen.new
  end
  alias :screen :controller

  it 'is a TableScreen' do
    screen.should.be.kind_of PM::GroupedTableScreen
  end
end