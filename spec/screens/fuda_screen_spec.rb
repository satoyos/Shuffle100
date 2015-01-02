describe 'FudaScreen' do
  tests FudaScreen
  alias :screen :controller

  describe '初期化' do
    it 'should be a valid screen' do
      screen.should.not.be.nil
      screen.is_a?(PM::Screen).should.be.true
    end

  end
end