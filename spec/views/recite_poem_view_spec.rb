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

  describe 'layout_with_top_offset' do
    before do
      @rp_view = RecitePoemView.alloc.init
      @rp_view.delegate = mock(:bounds, return: CGRectMake(0, 0, 320, 568))
    end

    it 'mockが正しく動作する' do
      @rp_view.delegate.bounds.tap do |b|
        b.should.not.be.nil
        b.should.be.kind_of(CGRect)
      end
    end

    it 'layout_with_top_offsetが落ちずに動作する' do
      @rp_view.layout_with_top_offset(94)
      1.should == 1
    end
  end

  describe 'show_waiting_to_pause' do
    before do
      rp_view = RecitePoemView.alloc.init
      rp_view.show_waiting_to_pause
      @play_button = rp_view.play_button
    end

    it 'ラベルタイトルが正しく設定されている' do
      @play_button.currentTitle.should == RecitePoemView::PLAY_BUTTON_PAUSING_TITLE
    end

    it 'PlayButtonのアクセさビリティラベルにアクセスできる' do
      @play_button.titleLabel.accessibilityLabel.should == RecitePoemView::ACC_LABEL_PAUSE
    end
  end

end