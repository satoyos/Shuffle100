describe 'RecitePoemView' do
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
end