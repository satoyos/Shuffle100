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

    it 'singer_indexを管理' do
      # newで生成された場合、値は必ず0になる
      @settings.singer_index.should == 0
    end

    it 'recite_modeを管理' do
      @settings.recite_mode_id.should == :normal
    end

    it 'fuda_setsを管理' do
      @settings.fuda_sets.is_a?(Array).should.be.true
      @settings.fuda_sets.size.should == 0
    end
  end

  describe '#set_recite_mode' do
    before do
      @settings = GameSettings.new
    end

    context '通常モードに設定' do
      it 'beginner_flgとrecite_modeが正しく設定されている' do
        @settings.tap do |s|
          s.set_recite_mode(:normal)
          s.beginner_flg.should == false
          s.recite_mode_id.should == :normal
        end
      end
    end
  end

  describe 'NSCodingプロトコル' do
    before do
      @settings = GameSettings.new
      test_status100 = SelectedStatus100.new(true)
      test_fuda_set = FudaSet.new('テスト1', test_status100)
      @settings.fuda_sets.push(test_fuda_set)
      @data_to_save = NSKeyedArchiver.archivedDataWithRootObject(@settings)
    end
    it 'セーブ対象データを作成できる' do
      @data_to_save.should.not.be.nil
    end
    it 'セーブ対象データからオブジェクトを復元できる' do
      loaded_settings =  NSKeyedUnarchiver.unarchiveObjectWithData(@data_to_save)
      loaded_settings.is_a?(GameSettings).should.be.true
      loaded_settings.fuda_sets.tap do |sets|
        sets.size.should == 1
        sets[0].name.should == 'テスト1'
        sets[0].status100.is_a?(SelectedStatus100).should.be.true
      end
    end
  end
end