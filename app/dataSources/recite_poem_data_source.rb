module RecitePoemDataSource
  def duration
    case self.current_player
      when nil; 1.0
      else    ; self.current_player.duration
    end
  end

  def currentTime
    case self.current_player
      when nil; 0.0
      else    ; self.current_player.currentTime
    end

  end

  def current_time_changed_to(time)
    return unless current_player
    current_player.stop
    current_player.currentTime = time
    current_player.prepareToPlay
    current_player.play
  end
end