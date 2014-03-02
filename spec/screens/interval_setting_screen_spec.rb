describe 'IntervalSettingController' do
  describe '初期化' do
    tests IntervalSettingScreen

    alias :screen :controller

    it 'should not be nil' do
      screen.should.not.be.nil
    end


    it '下の句プレーヤーと上の句プレーヤーを持つ' do
      screen.kami_player.tap do |player|
        player.should.not.be.nil
        player.should.be.kind_of(AVAudioPlayer)
      end
      screen.shimo_player.should.not.be.nil
    end

  end

  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end
end


