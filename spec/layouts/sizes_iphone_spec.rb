describe 'SizesIPhone' do
  before do
    @sizes = SizesIPhone.new
  end

  describe '初期化' do
    it 'should not be nil' do
      @sizes.should.not.be.nil
    end
  end

  describe '#play_button_size' do
    it 'should equal PlayButton size for iPhone' do
      @sizes.play_button_size.should.not.be.nil
      @sizes.play_button_size.should == SizesIPhone::PLAY_BUTTON_SIZE
    end
  end

  describe '#skip_button_size' do
    it 'should equal SkipButton size for iPhone' do
      @sizes.skip_button_size.should.not.be.nil
    end
  end
end