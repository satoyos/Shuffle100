class ReciteViewButton < UIButton
  GLAY_BRIGHTNESS = 0.9
  BORDER_WIDTH = 1.0 # ボタンの境界線の太さ

  class << self
    def buttonWithType(type)
      super.tap do |b|
        b.titleLabel.textAlignment = NSTextAlignmentCenter
        b.layer.tap do |l|
          l.masksToBounds = true
          l.borderWidth = BORDER_WIDTH
          l.borderColor = UIColor.darkGrayColor.CGColor
        end
        b.enabled = true
      end
    end
  end

=begin
  def drawRect(rect)
    # General Declarations
    colorSpace = CGColorSpaceCreateDeviceRGB()
    context = UIGraphicsGetCurrentContext()

    # Color Declarations
    color = UIColor.colorWithRed(GLAY_BRIGHTNESS,
                                 green: GLAY_BRIGHTNESS,
                                 blue: GLAY_BRIGHTNESS,
                                 alpha: 1)

    # Gradient Declarations
    gradientColors = [UIColor.whiteColor.CGColor, color.CGColor]

    gradient = CGGradientCreateWithColors(colorSpace, gradientColors, nil)

    # Rounded Rectangle Drawing
    CGContextSaveGState(context)
    startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect))
    endPoint   = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect))
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
    CGContextRestoreGState(context)


    # Cleanup
#    CGGradientRelease(gradient)
    CGColorSpaceRelease(colorSpace)

  end
=end

end