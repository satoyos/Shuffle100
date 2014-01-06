class RecitePoemView < UIView
  RP_VIEW_COLOR = UIColor.whiteColor

  def init
    super

    self.backgroundColor = RP_VIEW_COLOR
    set_play_button

    self
  end

  def set_play_button
    UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.accessibilityLabel = 'play_button'

      self.addSubview(b)
    end
  end
end