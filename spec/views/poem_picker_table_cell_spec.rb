describe 'PoemPickerTableCell' do
  before do
    @cell = PoemPickerTableCell.alloc.initWithFrame([[0, 0], [320, 60]])
  end

  describe '初期化' do
    it '正しく初期化されている' do
      @cell.should.not.be.nil
      @cell.is_a?(PoemPickerTableCell).should.be.true
    end
  end
end