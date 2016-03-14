class NonstopReciteScreen < BeginnerReciteScreen
  title 'ノンストップモードの歌詠み'

  def audioPlayerDidFinishPlaying(player, successfully: flag)
    return unless flag

    puts '- 読み上げが無事に終了！(ノンストップ・モード)' if BW2.debug?
    layout.play_finished_successfully
    if supplier.kami?
      recite_shimo_without_pause
    else
      recite_next_poem_without_pause
    end
  end
end