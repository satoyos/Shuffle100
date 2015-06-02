describe 'PoemPicker' do
  describe '初期化' do

    def controller
      @controller ||= PoemPicker.new.init_members
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

    it 'has 100 selected_status' do
      screen.status100.should.not.be.nil
      screen.status100.size.should == 100
    end

    it 'has a budge button that indicates number of selected poems' do
      screen.badge_button.should.not.be.nil
      screen.badge_button.badgeFont.is_a?(UIFont).should.be.true
    end
  end

  describe '検索' do
    before do
      @screen =  PoemPicker.new
      @screen.on_load
    end

    it 'should not be nil' do
      @screen.should.not.be.nil
    end

    it '検索窓に文字を入力すると検索が行われる' do
      search_bar = @screen.tableView.tableHeaderView
      search_bar.should.be.kind_of UISearchBar
      @screen.searching?.should.not.be.true
      search_bar.text = 'きみが'
      @screen.searching?.should.be.true
      # ap @screen.promotion_table_data.filtered_data
      @screen.promotion_table_data.filtered_data.first[:cells].size.should == 2
      lambda{@screen.refresh_search_result_table}.should.not.raise
      lambda{@screen.select_all_poems}.should.not.raise
    end
  end

end
