describe 'KamiShimoIntervalSettingScreen' do
  tests KamiShimoIntervalSettingScreen
  alias :screen :controller

  describe '初期化' do
    it 'should not be nil' do
      screen.should.not.be.nil
    end
    it '上の句用、下の句用のプレーヤーが設定されている' do
      screen.kami_player.should.be.kind_of AVAudioPlayer
      screen.shimo_player.should.be.kind_of AVAudioPlayer
    end
  end
end