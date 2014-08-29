describe 'BeginnerReciteScreen' do
  tests BeginnerReciteScreen

  def controller
    @controller ||= BeginnerReciteScreen.new
  end
  alias :screen :controller

  it 'is a kind of RecitePoemScreen' do
    screen.should.be.kind_of RecitePoemScreen
  end

  it '初心者モードのタイトル' do
    screen.title.should == '初心者モードの歌詠み'
  end
end