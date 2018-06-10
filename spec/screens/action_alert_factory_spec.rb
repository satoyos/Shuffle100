describe 'ActionAlertFactory' do
  AAF_TEST_INIT_HASH = {
      title: 'タイトル',
      message: 'メッセージ',
      actions: [
          {
              title: 'アクション1',
              handler: Proc.new {}
          },
          {
              title: 'アクション2',
              handler: Proc.new {}
          }
      ],
      cancel_title: 'キャンセル'
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
  it 'アクションが設定されている' do
    @alert.actions.size.should == 3
    @alert.actions.first.title.should == 'アクション1'
    @alert.actions.last.title.should == 'キャンセル'
  end
end