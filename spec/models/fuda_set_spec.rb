describe FudaSet do
  ODD_SET_STATUS  = (1..100).map{|n| n % 2 == 1 ? true : false}
  EVEN_SET_STATUS = (1..100).map{|n| n % 2 == 0 ? true : false}
  describe '初期化' do
    before do
      @set = FudaSet.new('偶数番の札', SelectedStatus100.new(EVEN_SET_STATUS))
      # @set = FudaSet.new
    end
    it 'should be a valid object' do
      @set.should.not.be.nil
      @set.is_a?(FudaSet).should.be.true
    end
    it 'プロパティがきちんと設定されている' do
      @set.name.should == '偶数番の札'
      @set.status100.is_a?(SelectedStatus100).should.be.true
      @set.status100.selected_num.should == 50
    end
  end

  describe 'NSCodingプロトコル' do
    before do
      @set = FudaSet.new('偶数番の札', SelectedStatus100.new(EVEN_SET_STATUS))
      @data_to_save = NSKeyedArchiver.archivedDataWithRootObject(@set)
    end
    it 'セーブ対象データを作成できる' do
      @data_to_save.should.not.be.nil
    end
    it 'セーブ対象データからオブジェクトを復元できる' do
      loaded_set =  NSKeyedUnarchiver.unarchiveObjectWithData(@data_to_save)
      loaded_set.is_a?(FudaSet).should.be.true
      loaded_set.name.should == @set.name
      loaded_set.status100.selected_num.should == 50
    end
  end
end