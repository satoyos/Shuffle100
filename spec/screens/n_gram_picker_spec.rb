describe 'NGramPicker' do
  tests NGramPicker

  def controller
    @controller ||= NGramPicker.new
  end
  alias :screen :controller

  describe '初期化' do

    it 'should not be nil' do
      controller.should.not.be.nil
    end
    it 'has a title' do
      controller.title.should.not.be.nil
    end
    it 'should not rotate' do
      screen.should_autorotate.should.be.false
    end
  end

  describe 'セクション付きのテーブルを表示する' do
    tests NGramPicker

    it 'support numberOfSectionsInTableView' do
      controller.numberOfSectionsInTableView(nil).should ==
          NGramPicker::N_GRAM_SECTIONS.size
    end

    it 'supports tableView:numberOfRowsInSection:' do
      # 2枚札(index=1)の1文字目は5種類ある
      controller.tableView(nil, numberOfRowsInSection: 1).should == 5
    end

  end

  describe 'selected_status_of_char' do
    U_SYMBOL = :u
    tests NGramPicker

    describe 'Context:「う」で始まる歌が全て選択されているとき' do
      before do
        stats = SelectedStatus100.one_side_array_of(false)
        NGramNumbers.indexes_of(U_SYMBOL).each do |idx|
          stats[idx] = true
        end
        controller.test_set_status100(stats)
      end

      it ':fullを返す' do
        controller.selected_status_of_char(U_SYMBOL).should == :full
      end
    end

    describe 'Context:「う」で始まる歌が全く選択されていないとき' do
      before do
        controller.test_set_status100(false)
      end

      it ':noneを返す' do
        controller.selected_status_of_char(U_SYMBOL).should == :none
      end
    end

    describe 'Context:「う」で始まる歌が一つだけ選択されているとき' do
      before do
        stats = SelectedStatus100.one_side_array_of(false)
        first_index = NGramNumbers.indexes_of(U_SYMBOL).first
        stats[first_index] = true
        controller.test_set_status100(stats)
      end

      it ':partialを返す' do
        controller.selected_status_of_char(U_SYMBOL).should == :partial
      end
    end
  end

  describe 'tap a cell' do
    tests NGramPicker
    TSU_SYMBOL = :tsu

    it '「つ」に対応するセルをタップできる' do
      #noinspection RubyArgCount
      tap "#{TSU_SYMBOL}"
      1.should == 1
    end
  end
end