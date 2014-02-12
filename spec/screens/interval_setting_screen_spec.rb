describe 'IntervalSettingController' do
  describe '初期化' do
    tests IntervalSettingScreen

    it 'should not be nil' do
      controller.should.not.be.nil
    end

    it '下の句プレーヤーと上の句プレーヤーを持つ' do
      controller.kami_player.tap do |player|
        player.should.not.be.nil
        player.should.be.kind_of(AVAudioPlayer)
      end
      controller.shimo_player.should.not.be.nil
    end

  end
end


