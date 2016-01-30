describe 'NonstopReciteScreen' do
  tests NonstopReciteScreen

  def controller
    @controller ||= NonstopReciteScreen.new
  end
  alias :screen :controller

  it 'is a kind of RecitePoemScreen' do
    screen.should.be.kind_of RecitePoemScreen
  end

  it '初心者モードのタイトル' do
    screen.title.should == 'ノンストップモードの歌詠み'
  end
end