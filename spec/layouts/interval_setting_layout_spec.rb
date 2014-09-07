describe 'IntervalSettingLayout' do
  before do
    @layout = IntervalSettingLayout.new.build
  end


  it 'should be a valid MK::Layout object' do
    @layout.should.not.be.nil
    @layout.should.be.kind_of MK::Layout
  end

  it 'has a white background' do
    @layout.view.backgroundColor.should == :white.uicolor
  end

  it 'has subviews' do
    @layout.tap do |l|
      l.get(:interval_label).should.not.be.nil
      l.get(:sec_label).should.not.be.nil
      l.get(:interval_slider).should.not.be.nil
      l.get(:try_button).should.not.be.nil
    end
  end
end