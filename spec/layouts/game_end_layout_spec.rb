describe 'GameEndLayout' do
  before do
    @layout = GameEndLayout.new.build
  end

  it 'should not be nil' do
    @layout.should.not.be.nil
  end

  it '「トップに戻る」ボタンに正しくaccessibilityLabelが設定されている' do
    @layout.get(:back_to_top_button).accessibilityLabel.should == 'back_to_top'
  end
end