describe 'BeginnerReciteLayout' do

  describe '初期化' do
    before do
      @layout = BeginnerReciteLayout.new
    end

    it 'should not be nil' do
      @layout.should.not.be.nil
    end

    it 'ia a kind of RecitePoemLayout' do
      @layout.should.be.kind_of RecitePoemLayout
    end

    it 'has a message label' do
      @layout.get(:message_label).should.not.be.nil
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
=end
  end
end
