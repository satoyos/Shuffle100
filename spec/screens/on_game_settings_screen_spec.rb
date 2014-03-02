describe 'OnGameSettingsScreen' do
  tests OnGameSettingsScreen

  def controller
    @controller ||= OnGameSettingsScreen.new
  end
  alias :screen :controller

  it 'should be a valid TableScreen' do
    screen.should.not.be.nil
    screen.should.be.kind_of(PM::TableScreen)
  end

  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end
end