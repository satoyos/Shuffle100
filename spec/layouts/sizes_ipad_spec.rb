describe 'SizesIPad' do
  before do
    @sizes = SizesIPad.new
  end

  describe '初期化' do
    it 'should.not.be.nil' do
      @sizes.should.not.be.nil
    end
  end

  describe '#play_button_size' do
    it 'should equal PlayButton size for iPad' do
      @sizes.play_button_size.should == SizesIPhone::PLAY_BUTTON_SIZE * 2
    end
  end

  describe '$skip_button_size' do
    it 'should equal SkipButton size for iPad' do
      @sizes.skip_button_size.should == SizesIPhone::SKIP_BUTTON_SIZE * 2
    end
  end

  describe '#whats_next_button_height' do
    it 'should equal height of buttons in WhatsNextScreen for iPad' do
      @sizes.whats_next_button_height.should.not.be.nil
      @sizes.whats_next_button_height.should == SizesIPhone::WHATS_NEXT_BUTTON_HEIGHT * 2
    end
  end

  describe '#image_offset_x' do
    it 'should be valid offset for iPad' do
      @sizes.image_offset_x.should == SizesIPad::IMAGE_OFFSET_X_IPAD
    end
  end

  describe '#nav_bar_button_size' do
    it 'should be valid size for iPad NavigationBarButton' do
      @sizes.nav_bar_button_size.should == SizesIPhone::NAV_BAR_BUTTON_SIZE * 2
    end
  end
end