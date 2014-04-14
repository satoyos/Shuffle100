describe 'PlayButtonBackView' do
  before do
    @button = ReciteViewButton.alloc.initWithFrame([CGPointZero, CGSizeMake(100, 100)])
  end

  it 'should not be nil' do
    @button.should.not.be.nil
    @button.should.be.kind_of(UIButton)

  end
end