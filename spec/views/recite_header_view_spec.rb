describe 'ReciteHeaderView' do
  describe '初期化' do
    before do
      @view = ReciteHeaderView.alloc.initWithFrame(CGRectZero)
    end

    it 'should be a valid view' do
      @view.should.not.be.nil
    end
  end
end