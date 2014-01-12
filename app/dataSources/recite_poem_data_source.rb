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
end