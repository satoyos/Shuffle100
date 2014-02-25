describe 'GameEndView' do
  before do
    @screen = GameEndView.alloc.initWithFrame(CGRectZero)
  end

  it 'should be a valid view' do
    @screen.should.not.be.nil
    @screen.should.be.kind_of UIView
  end
end