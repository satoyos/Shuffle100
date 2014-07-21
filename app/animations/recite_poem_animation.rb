module RecitePoemAnimation
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
end