describe 'GameSettings' do
  describe '初期化' do
    before do
      @settings = GameSettings.new
    end

    it 'should be a valid Settings' do
      @settings.should.not.be.nil
      @settings.should.be.kind_of(GameSettings)
    end
  end

  describe 'いろいろな設定値を管理' do
    before do
      @settings = GameSettings.new
    end

    it 'statuses_for_deck' do
      @settings.statuses_for_deck.tap do |statuses|
        statuses.should.not.be.nil
        statuses.should.be.kind_of(Array)
        statuses.first.should.be.kind_of(SelectedStatus100)
      end

    end

    it 'beginner_flg' do
      # newで生成された場合、値は必ずfalseになる
      @settings.beginner_flg.should.be.false
    end

  end
end