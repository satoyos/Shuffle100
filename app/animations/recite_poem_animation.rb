module RecitePoemAnimation
  ID_NEXT_POEM_FLIP = 'next_poem_flip'

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
    UIView.beginAnimations(ID_NEXT_POEM_FLIP, context: nil)
    UIView.setAnimationDelegate(self)
    UIView.setAnimationDuration(duration)
    UIView.setAnimationTransition(UIViewAnimationTransitionFlipFromLeft,
                                  forView: view,
                                  cache: true)
    yield
    UIView.setAnimationDidStopSelector(selector)
    UIView.commitAnimations
  end
end