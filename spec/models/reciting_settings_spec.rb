describe 'RecitingSettings' do
  describe '初期化' do
    before do
      @settings = RecitingSettings.new
    end

    it 'should be a valid Settings' do
      @settings.should.not.be.nil
      @settings.should.be.kind_of(RecitingSettings)
    end
  end

  describe 'いろいろな設定値を管理' do
    before do
      @settings = RecitingSettings.new
    end

    it 'interval_time' do
      @settings.interval_time.should.not.be.nil
    end

    it 'volume' do
      @settings.volume.should.not.be.nil
    end
  end
end