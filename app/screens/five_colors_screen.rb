class FiveColorsScreen < PM::Screen
  include SelectedStatusHandler

  title '五色百人一首の色で選ぶ'

  # BAR_BUTTON_SIZE = 28
  BAR_BUTTON_SIZE = 14

  attr_reader :layout, :badge_button, :status100

  def on_load
    @layout = FiveColorsLayout.new.tap{|l|
      l.sizes = app_delegate.sizes ? app_delegate.sizes :
                    OH::DeviceSizeManager.select_sizes  # こっちはRSpecテスト用。
    }
    self.view = layout.view
    self.navigationItem.prompt = AppDelegate::PROMPT
    init_members
    set_button_actions
    set_badge_button
    badge_button.button_size_plus(2)
  end

  def will_appear
    badge_button.badgeValue = "#{status100.selected_num}首"
  end

  private

  def init_members
    @status100 = loaded_selected_status
    @badge_button = PoemsNumberSelectedItem.create_with_origin_x(-50)
  end

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

  def set_badge_button
    set_nav_bar_button :right, {
        button: badge_button
    }
  end

end