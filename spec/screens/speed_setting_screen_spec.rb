describe 'SpeedSettingScreen' do
  tests SpeedSettingScreen
  alias :screen :controller

  describe '初期化' do

    it 'should not be nil' do
      screen.should.not.be.nil
    end

    it '上の句プレーヤーを持つ' do
      screen.kami_player.tap do |player|
        player.should.not.be.nil
        player.should.be.kind_of(AVAudioPlayer)
      end
    end
  end

  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end
end


