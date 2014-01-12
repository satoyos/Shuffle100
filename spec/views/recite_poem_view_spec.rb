describe 'RecitePoemView' do
  before do
    @rp_view = RecitePoemView.alloc.initWithFrame(CGRectZero)
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

  it '最初はボタンがポーズ状態' do
    @rp_view.start_reciting
    @rp_view.play_button.currentTitle.should ==
        RecitePoemView::PLAY_BUTTON_PAUSING_TITLE
  end

  it 'time_sliderが設定されている' do
    @rp_view.time_slider.should.not.be.nil
  end

end