describe 'GameEndScreen' do
  before do
    @screen = GameEndScreen.new
  end

  it 'should be a valid screen' do
    @screen.should.not.be.nil
    @screen.should.be.kind_of PM::Screen
  end
end