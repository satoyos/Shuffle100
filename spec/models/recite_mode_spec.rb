describe 'ReciteMode' do
  RM_INIT_HASH = {
      id: :normal,
      name: '通常（競技かるた）',
  }
  describe '初期化' do
    before do
      @recite_mode = ReciteMode.new(RM_INIT_HASH)
    end
    it 'should be a valid object' do
      @recite_mode.should.not.be.nil
    end
    it '初期化時に与えたプロパティを保持する' do
      RM_INIT_HASH.keys.each do |key|
        @recite_mode.send(key).should == RM_INIT_HASH[key]
      end
    end
  end

  describe 'self.recite_modes' do
    it 'should be an Array of ReciteMode' do
      ReciteMode.recite_modes.tap do |rm|
        rm.is_a?(Array).should.be.true
        rm.size.should == 3
        rm.first.is_a?(ReciteMode).should.be.true
      end
    end
  end

  describe 'self.default_recite_mode' do
    it 'should be a 1st recite_mode' do
      ReciteMode.default_recite_mode.tap do |m|
        m.is_a?(ReciteMode).should.be.true
        m.id.should == ReciteMode::RECITE_MODE_DATA.first[:id]
      end
    end
  end

  describe 'self.get_idx_of_recite_mode_id' do
    it '正しいindexを取得する' do
      ReciteMode.get_idx_of_recite_mode_id(:normal).should == 0
    end
  end

  describe 'self.get_recite_mode_of_id' do
    it '正しいReciteModeオブジェクト(通常モード)を取得する' do
      ReciteMode.get_recite_mode_of_id(:normal).tap do |recite_mode|
        recite_mode.is_a?(ReciteMode).should.be.true
        recite_mode.id.should == :normal
      end
    end
    it '正しいReciteModeオブジェクト(ノンストップ・モード)を取得する' do
      ReciteMode.get_recite_mode_of_id(:nonstop).tap do |recite_mode|
        recite_mode.id.should == :nonstop
      end
    end
  end
end

