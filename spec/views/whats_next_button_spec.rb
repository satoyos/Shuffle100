describe 'WhatsNextButton' do
  before do
    @button = WhatsNextButton.buttonWithType(UIButtonTypeRoundedRect).
        init_title_style_and_image('refrain.png')
  end
  it 'should not be nil' do
    @button.should.not.be.nil
  end
end