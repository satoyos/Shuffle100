class WhatsNextScreen < PM::Screen
  title '次はどうする？'

  attr_reader :layout

  def on_load
    @layout = WhatsNextLayout.new
    self.view = layout.view
    set_button_actions
  end

  private

  def set_button_actions
    layout.get(:refrain_button).on(:touch){
      puts '+ 「もう1回下の句」ボタンが押された！' if BW2.debug?
      refrain_button_pushed
    }
  end

  def refrain_button_pushed
    close(next: :refrain11)
  end
end