describe 'RecitePoemView' do
  describe '初期化' do
    before do
      @rp_view = RecitePoemView.alloc.init
    end

    it 'should be a valid view' do
      @rp_view.should.not.be.nil
    end

    it 'delegateが設定できる' do
      test_delegate = Object.new
      @rp_view.delegate = test_delegate
      @rp_view.delegate.should == test_delegate
    end

    it 'dataSourceが設定できる' do
      test_data_source = Object.new
      @rp_view.dataSource = test_data_source
      @rp_view.dataSource.should == test_data_source
    end

    it 'play_buttonが設定されている' do
      @rp_view.play_button.should.not.be.nil
      @rp_view.play_button.is_a?(UIButton).should.be.true
    end

=begin
    it '最初はボタンがポーズ状態' do
      @rp_view.start_reciting
      @rp_view.play_button.currentTitle.should ==
          RecitePoemView::PLAY_BUTTON_PAUSING_TITLE
    end
=end

    it 'progress_barが設定されている' do
      @rp_view.progress_bar.should.not.be.nil
    end

=begin
    it 'start_reciting' do
      @rp_view.start_reciting.should.be.true
    end
=end

  end

end