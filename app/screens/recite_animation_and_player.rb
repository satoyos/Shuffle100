# module for private methods of RecitePoemScreen

module ReciteAnimationAndPlayer
  SLIDING_EFFECT_DURATION = 0.2

  ID_NEXT_POEM_FLIP = 'next_poem_flip'
  ID_PREV_POEM_FLIP = 'prev_poem_flip'
  ID_GAME_END_FLIP  = 'game_end_flip'

  def self_view_animation_def(method_name, arg: arg, duration: duration, transition: transition, stop_selector: selector)
    UIView.beginAnimations(method_name, context: nil)
    UIView.setAnimationDelegate(self)
    UIView.setAnimationDuration(duration)
    if transition
      UIView.setAnimationTransition(transition,
                                    forView: self.view,
                                    cache: true)
    end
    if arg
      self.send("#{method_name}", arg)
    else
      self.send("#{method_name}")
    end
    UIView.setAnimationDidStopSelector(selector) if selector
    UIView.commitAnimations
  end

  def next_poem_flip_animate(duration, stop_selector: selector, &block)
    flip_view_animate(ID_NEXT_POEM_FLIP,
                      duration: duration,
                      transition: UIViewAnimationTransitionFlipFromLeft,
                      stop_selector: selector,
                      &block
    )
  end

  def prev_poem_flip_animate(duration, stop_selector: selector, &block)
    flip_view_animate(ID_PREV_POEM_FLIP,
                      duration: duration,
                      transition: UIViewAnimationTransitionFlipFromRight,
                      stop_selector: selector,
                      &block
    )
  end


  def game_end_flip_animate(duration, stop_selector: selector, &block)
    flip_view_animate(ID_GAME_END_FLIP,
                      duration: duration,
                      transition: UIViewAnimationTransitionFlipFromLeft,
                      stop_selector: selector,
                      &block
    )
  end

  private

  def flip_view_animate(animation_id, duration: duration, transition: transition, stop_selector: selector, &block)
    UIView.beginAnimations(animation_id, context: nil)
    UIView.setAnimationDelegate(self)
    UIView.setAnimationDuration(duration)
    UIView.setAnimationTransition(transition, forView: view, cache: true)
    yield
    UIView.setAnimationDidStopSelector(selector)
    UIView.commitAnimations
  end

  def fetch_player
    @current_player = AudioPlayerFactory.create_player_of(supplier.poem, side: supplier.side)
    current_player.delegate = self
    set_player_volume
  end

  def set_player_volume
    current_player.volume = app_delegate.reciting_settings.volume
  end

  def transit_kami_shimo
    @current_player = AudioPlayerFactory.create_player_of(poem, side: :shimo)
    recite_view_slide_in_from(:right)
  end

  def transit_shimo_kami
    @current_player = AudioPlayerFactory.create_player_of(poem, side: :kami)
    recite_view_slide_in_from(:left)
  end

  def recite_view_slide_in_from(location)
    prev_view = view.subviews.first
    renew_layout_and_player
    layout.show_waiting_to_play
    layout.title = create_current_title
    add layout.view
    layout.locate_view(location)
    UIView.animateWithDuration(SLIDING_EFFECT_DURATION, animations: lambda{
      layout.locate_view(:normal)
    }, completion: lambda{|finished|
      remove prev_view
    })
  end

  def view_animation_has_finished(animation_id)
    case animation_id
      when ID_NEXT_POEM_FLIP
        recite_poem
      else
        puts "/////// このアニメーションの後処理はありません。 ///////" if BW2.debug?
    end
  end
end