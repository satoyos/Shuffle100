describe 'PlayButtonBackView' do
  before do
    @button = ReciteViewButton.buttonWithType(UIButtonTypeCustom)
  end

  it 'should not be nil' do
    @button.should.not.be.nil
    @button.should.be.kind_of(UIButton)

  end
end