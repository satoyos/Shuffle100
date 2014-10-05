describe 'BarExitButton' do
  describe '初期化' do
    before do
      @button = BarExitButton.create_with_square_size(25)
    end
    it 'should not be a valid button' do
      @button.should.not.be.nil
      @button.should.be.kind_of UIButton
    end

    it 'should have an accessibilityLabel' do
      @button.accessibilityLabel.should == 'exit'
    end
  end
end