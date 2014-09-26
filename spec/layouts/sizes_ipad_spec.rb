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
end