describe 'FudaView' do
  SHIMO_STR = 'おきまどわせるしらきくのはな'
  INITIAL_HEIGHT = 400
  before do
    @fuda_view = FudaView.alloc.initWithString(SHIMO_STR)
  end
  describe 'initialize with string' do
    it 'should not be nil' do
      @fuda_view.should.not.be.nil
    end
    it 'should have accessibilityLabel' do
      @fuda_view.accessibilityLabel.should.equal FudaView::ACCESSIBILITY_LABEL
    end
    it 'should have labels created from SHIMO_STR ' do
      @fuda_view.instance_eval do
        @labels15.size.should == 15
        idx = Random.new.rand(0..14)
        @labels15[idx].text.should.be.equal (SHIMO_STR[idx] || '')
        @labels15[idx].accessibilityLabel.should.be.eql? FudaView::STR_FOR_FUDA_LABEL_ACC % idx
      end
    end
    it 'should have labels of INITIAL_FUDA_FONT' do
      @fuda_view.instance_eval do
        @labels15[0].font.should.be.equal FudaView::INITIAL_FUDA_FONT
      end
    end
  end



  describe 'set_size_by_height' do

    before do
      # 一度札Viewの高さをINITIAL_HEIGHTに設定しておき、その時の諸々のサイズを取得しておく。
      @fuda_view.set_all_sizes_by(INITIAL_HEIGHT)
      @fuda_view.instance_eval do
        @org_inside_view_size = @fuda_inside_view.frame.size
        @org_label_size = @labels15.first.frame.size
      end

      # その後、札Viewの高さをINITIAL_HEIGHTの半分に再設定。
      @fuda_view.set_all_sizes_by(INITIAL_HEIGHT/2)

    end
    it 'should have half size frame' do
      @fuda_view.frame.size.height.should.close?(INITIAL_HEIGHT/2, 1.0)
    end
    it 'should have subViews of half size' do

      @fuda_view.instance_eval do
        @fuda_inside_view.frame.size.height.should.close?(@org_inside_view_size.height/2, 1.0)
        @labels15.first.frame.size.height.should.close?(@org_label_size.height/2, 1.0)
      end
    end
  end

  describe 'rewrite_string' do
    ORG_SHIMO_STR = FudaView::STRING_NOT_SET_MESSAGE
    NEW_SHIMO_STR = 'わかみよにふるなかめせしまに'
    before do
      @fuda_view = FudaView.alloc.initWithString(ORG_SHIMO_STR)
    end

    it 'should change content string' do
      l_idx = 1
      @fuda_view.rewrite_string(NEW_SHIMO_STR)
      @fuda_view.labels15[l_idx].tap do |label|
        label.should.not.be.nil
        label.is_a?(UILabel).should.be.true
        label.text.should == NEW_SHIMO_STR.split(//u)[l_idx]
      end

    end

  end

end
