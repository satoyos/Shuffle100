describe 'NameNewSetLayout' do
  describe '初期化' do
    before do
      @layout = NameNewSetLayout.new.tap{|l|
        # l.sizes = OH::DeviceSizeManager.select_sizes
      }.build
    end

    it 'should not be nil' do
      @layout.should.not.be.nil
    end

    it '名前を入力するフィールドが設置されている' do
      @layout.get(:name_field).should.not.be.nil
      @layout.get(:name_field).is_a?(UITextField).should.be.true
    end

    it 'キャンセルボタンが設置されている' do
      @layout.get(:cancel_button).should.not.be.nil
      @layout.get(:cancel_button).is_a?(UIButton).should.be.true
    end
  end

end

