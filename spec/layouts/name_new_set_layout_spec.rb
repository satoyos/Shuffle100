describe 'NameNewSetLayout' do
  describe '初期化' do
    before do
      @layout = NameNewSetLayout.new.tap{|l|
        # l.sizes = OH::DeviceSizeManager.select_sizes
      }.build
    end

    it 'should not be nil' do
      @layout.should.not.be.nil
    end

    it '名前を入力するフィールドが設置されている' do
      @layout.get(:name_field).should.not.be.nil
      @layout.get(:name_field).is_a?(UITextField).should.be.true
    end

    it 'キャンセルボタンが設置されている' do
      @layout.get(:cancel_button).should.not.be.nil
      @layout.get(:cancel_button).is_a?(UIButton).should.be.true
    end
=begin
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
    it 'notice_labelが設定されている' do
      @layout.get(:notice_label).tap do |n_label|
        n_label.should.not.be.nil
        n_label.backgroundColor.should == RecitePoemStyles::NOTICE_LABEL_BACKCOLOR
      end
    end
=end
  end

end

