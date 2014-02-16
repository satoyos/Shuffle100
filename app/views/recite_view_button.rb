class ReciteViewButton < UIButton
  GLAY_BLIGHTNESS = 0.9

#  def init
  class << self
    def buttonWithType(type)
      button = super
      
      button.tap do |b|
        b.titleLabel.textAlignment = NSTextAlignmentCenter
        b.layer.tap do |l|
          l.masksToBounds = true
          l.borderWidth = 1.0
          l.borderColor = UIColor.darkGrayColor.CGColor
        end
        b.enabled = true
      end
      button
    end
  end

  def drawRect(rect)
    # General Declarations
    colorSpace = CGColorSpaceCreateDeviceRGB()
    context = UIGraphicsGetCurrentContext()

    # Color Declarations
    color = UIColor.colorWithRed(GLAY_BLIGHTNESS,
                                 green: GLAY_BLIGHTNESS,
                                 blue: GLAY_BLIGHTNESS,
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

end