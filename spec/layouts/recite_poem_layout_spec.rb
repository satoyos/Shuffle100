describe 'RecitePoemLayout' do
  describe '初期化' do
    before do
      @layout = RecitePoemLayout.new.build
    end

    it 'should not be nil' do
      @layout.should.not.be.nil
    end

    it '背景色は白' do
      @layout.view.backgroundColor.should == UIColor.whiteColor
    end

    it '各ボタンにAccessibilityLabelが付与されている' do
      [:play_button, :quit_button, :gear_button].each do |button_sym|
        @layout.get(button_sym).accessibilityLabel.should == button_sym.to_s
      end
      [:forward, :rewind].each do |button_sym|
        @layout.get("#{button_sym}_button".to_sym).accessibilityLabel.should ==
            button_sym.to_s
      end
    end
  end

  describe 'locate_rp_view' do
    FRAME_WIDTH = 320

    before do
      @layout = RecitePoemLayout.new
    end

    context 'right' do
      it '画面の外(右側)に位置する' do
        @layout.locate_view(:right)
        @layout.view.frame.origin.x.should == FRAME_WIDTH
      end
    end

    context 'left' do
      it '画面の外(左側)に位置する' do
        @layout.locate_view(:left)
        @layout.view.frame.origin.x.should == -1 * FRAME_WIDTH
      end
    end
  end
end