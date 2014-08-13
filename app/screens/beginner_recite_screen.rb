class BeginnerReciteScreen < RecitePoemScreen
  title '初心者モードの歌詠み'

  def on_load
    puts "上の句と下の句の間隔 => #{app_delegate.game_settings.kami_shimo_interval}" if BW2.debug?
    super
  end

  private

  def create_new_layout
    @layout = BeginnerReciteLayout.new.tap{|l| l.delegate = self}
    set_button_actions
  end
end