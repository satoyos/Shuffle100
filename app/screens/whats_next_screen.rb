class WhatsNextScreen < PM::Screen
  title '次はどうする？'

  attr_reader :layout

  def on_load
    @layout = WhatsNextLayout.new
    self.view = layout.view
  end
end