describe 'GameEndView' do
  before do
    @ge_view = GameEndView.alloc.initWithFrame(CGRectZero, header_height: 60)
  end

  it 'should be a valid view' do
    @ge_view.should.not.be.nil
    @ge_view.should.be.kind_of UIView
  end
end