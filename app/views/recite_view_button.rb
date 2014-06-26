class ReciteViewButton < UIButton
  GLAY_BRIGHTNESS = 0.9
  BORDER_WIDTH = 1.0 # ボタンの境界線の太さ

  def initWithFrame(frame)
=begin
    super.tap do |b|
      b.titleLabel.textAlignment = NSTextAlignmentCenter
      b.layer.tap do |l|
        l.masksToBounds = true
        l.borderWidth = BORDER_WIDTH
        l.borderColor = UIColor.darkGrayColor.CGColor
        l.cornerRadius = self.frame.size.height / 2
      end
      b.setupBackgroundGradientForState(
          UIControlStateNormal,
          colors: [UIColor.whiteColor.CGColor,
                   UIColor.colorWithRed(GLAY_BRIGHTNESS,
                                        green: GLAY_BRIGHTNESS,
                                        blue: GLAY_BRIGHTNESS,
                                        alpha: 1).CGColor])
    end
=end
    super
    init_recite_view_button

    self
  end
  
  def init_recite_view_button
    self.titleLabel.textAlignment = NSTextAlignmentCenter
    self.layer.tap do |l|
      l.masksToBounds = true
      l.borderWidth = BORDER_WIDTH
      l.borderColor = UIColor.darkGrayColor.CGColor
      l.cornerRadius = self.frame.size.height / 2
    end
    setupBackgroundGradientForState(
        UIControlStateNormal,
        colors: [UIColor.whiteColor.CGColor,
                 UIColor.colorWithRed(GLAY_BRIGHTNESS,
                                      green: GLAY_BRIGHTNESS,
                                      blue: GLAY_BRIGHTNESS,
                                      alpha: 1).CGColor])
  end

  def set_title(title, left_inset: l_inset, color: color)
    UIEdgeInsets.new.tap do |insets|
      insets.left = l_inset
      contentEdgeInsets = insets
    end
    setTitle(title, forState: UIControlStateNormal)
    setTitleColor(color, forState: UIControlStateNormal)
    setTitleColor(color.colorWithAlphaComponent(0.25),
                  forState: UIControlStateHighlighted | UIControlStateDisabled)
  end


  private

  def setupBackgroundGradientForState(state, colors:colors)
    gradient = CAGradientLayer.alloc.init
    gradient.frame = self.bounds
    gradient.colors = colors

    UIGraphicsBeginImageContext(CGSizeMake(1, self.bounds.size.height))
    gradient.renderInContext(UIGraphicsGetCurrentContext())
    bgImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.setBackgroundImage(bgImage, forState:state)
  end

end