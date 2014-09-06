class BeginnerReciteScreen < RecitePoemScreen
  title '初心者モードの歌詠み'

  def on_load
    puts "上の句と下の句の間隔 => #{app_delegate.reciting_settings.kami_shimo_interval}" if BW2.debug?
    super
  end

  def audioPlayerDidFinishPlaying(player, successfully: flag)
    return unless flag

    puts '- 読み上げが無事に終了！(初心者モード)' if BW2.debug?
    layout.play_finished_successfully
    if supplier.kami?
      supplier.step_into_shimo
      transit_kami_shimo
      slide_effect_duration.second.later do
        layout.show_waiting_to_pause
        layout.title = create_current_title
        recite_poem
      end
    else
      if supplier.current_index == 0 # 序歌を読み終えた
        supplier.draw_next_poem
        goto_next_poem
      else
        open_modal WhatsNextScreen.new(nav_bar: true)
      end
    end
  end

  def on_return(args={})
    super
    return unless args[:next]
    case args[:next]
      when :refrain; refrain_shimo
      when :next_poem; try_to_draw_next_poem
      else
        raise "「次はどうする？」画面を[#{args[:next]}]で終える場合は、まだサポートしていません。"
    end
  end

  private

  def create_new_layout
    @layout = BeginnerReciteLayout.new.tap{|l| l.delegate = self}.build
    set_button_actions
  end

  def refrain_shimo
    current_player.prepareToPlay
    recite_poem
  end

  def try_to_draw_next_poem
    if supplier.draw_next_poem # 次の歌がある
      goto_next_poem
    else                        # 次の歌がない (最後の歌だった)
      end_of_the_game
    end
  end

  def slide_effect_duration
    app_delegate.reciting_settings.kami_shimo_interval
  end
end