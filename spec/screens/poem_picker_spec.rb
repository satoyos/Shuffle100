describe 'PoemPicker' do
  describe '初期化' do
    tests PoemPicker

    it 'should not be nil' do
      controller.should.not.be.nil
    end

    it 'has 100 poems' do
      controller.poems.should.not.be.nil
      controller.poems.size.should == 100
      controller.poems.first.is_a?(Poem).should.be.true
    end

    it 'has 100 selected_status' do
      controller.status100.should.not.be.nil
      controller.status100.size.should == 100
#      controller.selected.first.is_a?(FalseClass).should.be.true
    end

    it 'has a tableView' do
      controller.table_view.should.not.be.nil
      controller.table_view.is_a?(UITableView).should.be.true
    end
  end

  describe 'テーブル表示' do
    tests PoemPicker

    it 'テーブルの要素数を返す' do
      controller.tableView(nil, numberOfRowsInSection: 0).should == 100
    end
  end
end