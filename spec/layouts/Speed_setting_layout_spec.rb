describe 'SpeedSettingLayout' do
  before do
    @layout = SpeedSettingLayout.new.tap{|l|
      l.sizes = OH::DeviceSizeManager.select_sizes
    }.build
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
      l.get(:rate_label).should.not.be.nil
      l.get(:x_label).should.not.be.nil
      l.get(:rate_slider).should.not.be.nil
      l.get(:try_button).should.not.be.nil
      l.slider.should.not.be.nil
      l.try_button.should.not.be.nil
    end
  end
end