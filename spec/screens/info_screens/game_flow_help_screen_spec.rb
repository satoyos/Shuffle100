describe 'GameFlowHelpScreen' do
  tests GameFlowHelpScreen

  def controller
    @controller ||= GameFlowHelpScreen.new
  end
  alias :screen :controller

  it 'should not be nil' do
    screen.should.not.be.nil
  end

  it 'should be a PM::WebScreen' do
    screen.should.be.kind_of(PM::WebScreen)
  end

  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end
end