describe 'FiveColrosScreen' do
  tests FiveColorsScreen

  def controller
    @controller ||= FiveColorsScreen.new
  end
  alias :screen :controller

  it 'is a kind of PM::Screen' do
    screen.should.be.kind_of PM::Screen
  end
  it 'タイトルが正しく設定されている' do
    screen.title.should == '五色百人一首'
  end
  it '背景の色が正しく設定されている' do
    screen.view.backgroundColor.should == UIColor.whiteColor
  end
  it 'Layoutが設定されている' do
    screen.layout.should.not.be.nil
  end

  describe 'selected_status_of_color' do
    GREEN_SYMBOL = :green
    tests FiveColorsScreen

    describe '緑グループの歌が全て選択されているとき' do
      before do
        stats = SelectedStatus100.one_side_array_of(false)
        FiveColors::GREEN_NUMBERS.each do |idx|
          stats[idx-1] = true
        end
        controller.test_set_status100(stats)
      end

      it ':fullを返す' do
        controller.selected_status_of_color(GREEN_SYMBOL).should == :full
      end
    end

    describe '緑グループの歌が全く選択されていないとき' do
      before do
        controller.test_set_status100(false)
      end

      it ':noneを返す' do
        controller.selected_status_of_color(GREEN_SYMBOL).should == :none
      end
    end

    describe '緑グループの歌が一つだけ選択されているとき' do
      before do
        stats = SelectedStatus100.one_side_array_of(false)
        first_index = FiveColors::GREEN_NUMBERS.first
        stats[first_index-1] = true
        controller.test_set_status100(stats)
      end

      it ':partialを返す' do
        controller.selected_status_of_color(GREEN_SYMBOL).should == :partial
      end
    end
  end
end