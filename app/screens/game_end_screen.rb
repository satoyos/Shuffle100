class GameEndScreen < PM::Screen
  title '試合終了'

  def on_load
    init_appearance
    view.backgroundColor= UIColor.whiteColor
    add self.back_to_top_button
  end

  def init_appearance
    if self.navigationController
      puts " - #{self}の画面にPromptを設定します" if BW::debug?
      self.navigationController.navigationBar.topItem.prompt = AppDelegate::PROMPT
      puts '  → [%s]に設定しました。' %
               self.navigationController.navigationBar.topItem.prompt
    end
  end

  def back_to_top_button
    @back_to_top_button ||=
        UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
          b.frame = [[0, 0], [200, 80]]
          b.center = view.center
          b.setTitle('トップに戻る', forState: UIControlStateNormal)
          b.addTarget(self,
                      action: :back_button_pushed,
                      forControlEvents: UIControlEventTouchUpInside)
        end
  end

  def back_button_pushed
    puts '[Back to Top] button pushed!' if BW::debug?
    open_root_screen HomeScreen
  end


end