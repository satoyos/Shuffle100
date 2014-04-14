class ReciteViewButton < UIButton
  GLAY_BRIGHTNESS = 0.9
  BORDER_WIDTH = 1.0 # ボタンの境界線の太さ

  def initWithFrame(frame)
    super.tap do |b|
      b.titleLabel.textAlignment = NSTextAlignmentCenter
      b.layer.tap do |l|
        l.masksToBounds = true
        l.borderWidth = BORDER_WIDTH
        l.borderColor = UIColor.darkGrayColor.CGColor
      end
      b.setupBackgroundGradientForState(
          UIControlStateNormal,
          colors: [UIColor.whiteColor.CGColor,
                   UIColor.colorWithRed(GLAY_BRIGHTNESS,
                                        green: GLAY_BRIGHTNESS,
                                        blue: GLAY_BRIGHTNESS,
                                        alpha: 1).CGColor])
    end

    self
  end


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