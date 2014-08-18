class BeginnerReciteScreen < RecitePoemScreen
  title '初心者モードの歌詠み'

  def on_load
    puts "上の句と下の句の間隔 => #{app_delegate.game_settings.kami_shimo_interval}" if BW2.debug?
    super
  end

  def audioPlayerDidFinishPlaying(player, successfully: flag)
    return unless flag

    puts '- 読み上げが無事に終了！(初心者モード)' if BW2.debug?
    layout.play_finished_successfully
    if supplier.kami?
      supplier.step_into_shimo
      transit_kami_shimo
      SLIDING_EFFECT_DURATION.second.later do
        layout.show_waiting_to_pause
        layout.title = create_current_title
        recite_poem
      end
    else
      supplier.draw_next_poem
      if supplier.current_index == 1 # 序歌を読み終えた
        goto_next_poem
      else
        open_modal WhatsNextScreen.new(nav_bar: true)
      end
    end
  end

  def on_return(args={})

  end

  private

  def create_new_layout
    @layout = BeginnerReciteLayout.new.tap{|l| l.delegate = self}
    set_button_actions
  end
end