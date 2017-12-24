class FiveColorsScreen < PM::Screen
  title '五色百人一首の色で選ぶ'

  # BAR_BUTTON_SIZE = 28
  BAR_BUTTON_SIZE = 14

  attr_reader :layout

  def on_load
    @layout = FiveColorsLayout.new.tap{|l|
      l.sizes = app_delegate.sizes ? app_delegate.sizes :
                    OH::DeviceSizeManager.select_sizes  # こっちはRSpecテスト用。
    }
    self.view = layout.view
    set_button_actions
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
=begin
    layout.get(:refrain_button).on(:touch){
      puts '+ 「もう1回下の句」ボタンが押された！' if BW2.debug?
      close(next: :refrain)
    }
    layout.get(:next_poem_button).on(:touch){
      puts '+ 「次の歌へ！」ボタンが押された！' if BW2.debug?
      close(next: :next_poem)
    }
    layout.get(:torifuda_button).on(:touch){
      puts '+ 「取り札を見る」ボタンが押された！' if BW2.debug?
      show_torifuda
    }
    @gear_button.on(:touch){
      puts '+ 「いろいろな設定」ボタンが押された！' if BW2.debug?
      open_on_game_settings
    }
    @exit_button.on(:touch){
      puts '+ 終了ボタンが押された！' if BW2.debug?
      confirm_user_to_quit
    }
=end
  end

=begin
  def open_on_game_settings
    open OnGameSettingsScreen.new, modal: true, nav_bar: true
  end

  def back_to_top_screen
    close(next: :back_to_top)
  end

  def show_torifuda
    open_modal FudaScreen.new(nav_bar: true).tap{|s|
                 s.fuda_str = parent_screen.poem.in_hiragana.shimo
                 s.nav_bar_title = parent_screen.poem.str_with_number_and_liner
               }
  end
=end
end