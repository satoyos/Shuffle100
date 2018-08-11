describe 'FudaSetsScreen' do
  tests FudaSetsScreen

  def controller
    @controller ||= FudaSetsScreen.new
  end
  alias :screen :controller

  it 'should not be nil' do
    screen.should.not.be.nil
  end

  it 'is a GroupedTableScreen' do
    screen.should.be.kind_of PM::TableScreen
  end

  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end

end