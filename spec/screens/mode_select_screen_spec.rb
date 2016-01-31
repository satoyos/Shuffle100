describe 'ModeSelectScreen' do
  describe '初期化' do

    def controller
      @controller ||= ModeSelectScreen.new
    end
    alias :screen :controller

    it 'should not be nil' do
      screen.should.not.be.nil
    end

    it 'has a view of white background' do
      screen.view.backgroundColor.should == UIColor.whiteColor
    end
    it 'タイトルが設定されている' do
      screen.title.should == '読み上げモードを選ぶ'
    end
    it '読み手データを正しく読み込んでいる' do
      screen.recite_modes.size.should == ReciteMode::RECITE_MODE_DATA.size
      screen.recite_modes.first.is_a?(ReciteMode).should.be.true
    end
    it 'PickerViewにAccessibilityLabelが設定されている' do
      screen.picker_view.accessibilityLabel.should == 'picker_view'
    end
  end
end

