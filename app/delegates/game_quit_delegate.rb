module GameQuitDelegate
  private

  def confirm_user_to_quit
    UIAlertView.alert('試合を終了しますか？',
                      buttons: ['終了する', '続ける']
    ) do |button, button_index|
      if button == '終了する'
        puts '[quit] 試合を終了します' if BW2.debug?
        back_to_top_screen
      else
        puts '[continue] 試合を続行します' if BW2.debug?
      end
    end
  end
end