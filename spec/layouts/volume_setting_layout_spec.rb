describe 'VolumeSettingLayout' do
  before do
    @layout = VolumeSettingLayout.new.build
  end

  it 'should be a valid Layout' do
    @layout.should.not.be.nil
    @layout.should.be.kind_of MK::Layout
  end

  it 'has some parts' do
    @layout.get(:play_button).should.not.be.nil
    @layout.get(:slider).should.not.be.nil
  end

  it 'has white backgroundColor' do
    @layout.view.backgroundColor.should == :white.uicolor
  end
end