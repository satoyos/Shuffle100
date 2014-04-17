describe 'PoemPicker' do
  describe '初期化' do
#    tests PoemPicker

    def controller
      @controller ||= PoemPicker.new
    end
    alias :screen :controller


    it 'should not be nil' do
      screen.should.not.be.nil
    end

    it 'has 100 poems' do
      screen.poems.should.not.be.nil
      screen.poems.size.should == 100
      screen.poems.first.is_a?(Poem).should.be.true
    end

=begin
    it 'has 100 selected_status' do
      screen.status100.should.not.be.nil
      screen.status100.size.should == 100
    end

    it 'has a tableView' do
      screen.table_view.should.not.be.nil
      screen.table_view.is_a?(UITableView).should.be.true
    end
=end
  end

=begin
  describe 'テーブル表示' do
    # tests PoemPicker
    def controller
      @controller ||= PoemPicker.new.on_load
    end
    alias :screen :controller

    it 'テーブルの要素数を返す' do
      screen.tableView(nil, numberOfRowsInSection: 0).should == 100
    end
  end
=end
end
