describe 'FudaSetsScreen' do
  tests FudaSetsScreen

  def controller
    @controller ||= FudaSetsScreen.new
  end
  alias :screen :controller

  it 'should not be nil' do
    screen.should.not.be.nil
  end

  it 'is a GroupedTableScreen' do
    screen.should.be.kind_of PM::TableScreen
  end

=begin
  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end

  describe '#review_page_url' do
    it 'returns correct url string' do
      screen.review_page_url.should == 'itms-apps://itunes.apple.com/app/id857819404'
      'AppStoreID'.info_plist.should == '857819404'
    end
  end
=end
end