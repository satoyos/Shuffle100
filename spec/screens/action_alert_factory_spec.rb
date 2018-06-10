describe 'ActionAlertFactory' do
  AAF_TEST_INIT_HASH = {
      title: 'タイトル',
      message: 'メッセージ',
      actions: [
          {

          }
      ],
      cancel_str: 'キャンセル'
  }
  before do
    @alert = ActionAlertFactory.create_alert(AAF_TEST_INIT_HASH)
  end

  it 'creates an AlertController of Style [Action Sheet]' do
    @alert.should.not.be.nil
    @alert.is_a?(UIAlertController).should.be.true
    @alert.preferredStyle.should. == UIAlertControllerStyleActionSheet
  end
  it '指定したタイトルとメッセージが設定されている' do
    @alert.title.should == 'タイトル'
    @alert.message.should == 'メッセージ'
  end
end