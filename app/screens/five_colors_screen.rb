class FiveColorsScreen < PM::Screen
  include SelectedStatusHandler

  title '五色百人一首'

  BAR_BUTTON_SIZE = 14

  attr_reader :layout

  def on_load
    @layout = FiveColorsLayout.new.tap{|l|
      l.sizes = app_delegate.sizes ? app_delegate.sizes :
                    OH::DeviceSizeManager.select_sizes  # こっちはRSpecテスト用。
    }
    self.view = layout.view
    self.navigationItem.prompt = AppDelegate::PROMPT
    set_button_actions
    init_selected_status_and_badge
  end

  private

  def set_button_actions
    layout.get(:blue_group_button).on(:touch) {
      puts '+ 「青グループ」ボタンが押された！' if BW2.debug?
      alert = UIAlertController.alertControllerWithTitle('Title', message: 'This is the message area.', preferredStyle: UIAlertControllerStyleActionSheet )
      select20 = UIAlertAction.actionWithTitle(
          '選ぶ',
          style: UIAlertActionStyleDefault,
          handler: Proc.new{|obj| puts "[選ぶ]が選択された"})
      cancel = UIAlertAction.actionWithTitle(
          'キャンセル',
          style: UIAlertActionStyleCancel,
          handler: nil)
      alert.addAction(select20)
      alert.addAction(cancel)
      self.presentViewController(alert, animated: true, completion: nil)
    }
  end

end