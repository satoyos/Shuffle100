describe 'SettingsManager' do
  describe '初期化' do
    before do
      @manager = SettingsManager.new
    end

    it 'should not be nil' do
      @manager.should.not.be.nil
    end

    it 'プロパティとして reciting_settingsを持つ' do
      @manager.reciting_settings.should.not.be.nil
    end

    it 'プロパティとして game_setttingsを持つ' do
      @manager.game_settings.should.not.be.nil
    end
  end
end