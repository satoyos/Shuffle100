describe 'SettingsManager' do
  before do
    @manager = SettingsManager.new
  end

  describe '初期化' do
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

  describe '#rs_data_to_save' do
    it 'should not be a valid object' do
      @manager.rs_data_to_save.should.not.be.nil
    end
  end

  describe '#unarchived_rs_data' do
    before do
      rs_data = @manager.rs_data_to_save
      @loaded_rs_data = @manager.unarchived_rs_data(rs_data)
    end
    it 'should extract object from archived data' do
      @loaded_rs_data.tap do |rs|
        rs.should.not.be.nil
        rs.is_a?(RecitingSettings).should.be.true
        rs.volume.should == RecitingSettings::DEFAULT_VOLUME
      end
    end
  end

  describe '#gs_data_to_save' do
    it 'should not be a valid object' do
      @manager.gs_data_to_save.is_a?(NSConcreteMutableData).should.be.true
    end
  end

  describe '#unarchived_gs_data' do
    before do
      gs_data = @manager.gs_data_to_save
      @loaded_gs_data = @manager.unarchived_gs_data(gs_data)
    end
    it 'should extract object from archived data' do
      @loaded_gs_data.tap do |gs|
        gs.should.not.be.nil
        gs.is_a?(GameSettings).should.be.true
        gs.statuses_for_deck.first.tap do |first_100|
          first_100.is_a?(SelectedStatus100).should.be.true
        end
      end
    end
  end
end