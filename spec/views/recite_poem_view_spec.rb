describe 'RecitePoemView' do
  before do
    @rp_view = RecitePoemView.alloc.init
  end

  it 'should be a valid view' do
    @rp_view.should.not.be.nil
  end
end