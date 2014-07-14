class ReciteViewButton < UIButton
  GRAY_BRIGHTNESS = 0.9
  BORDER_WIDTH = 1.0 # ボタンの境界線の太さ

  def initWithFrame(frame)
    super
    init_recite_view_button('aaa')

    self
  end
  
  def init_recite_view_button(name)
    raise 'ボタンの名前を引数で指定してください' unless name
    self.titleLabel.textAlignment = NSTextAlignmentCenter
    self.layer.tap do |l|
      l.masksToBounds = true
      l.borderWidth = BORDER_WIDTH
      l.borderColor = UIColor.darkGrayColor.CGColor
      l.cornerRadius = self.frame.size.height / 2
    end
    set_background_gradient(name,
        forState: UIControlStateNormal,
        colors: [UIColor.whiteColor.CGColor,
                 UIColor.colorWithRed(GRAY_BRIGHTNESS,
                                      green: GRAY_BRIGHTNESS,
                                      blue: GRAY_BRIGHTNESS,
                                      alpha: 1).CGColor])
  end

  def set_title(title, left_inset: l_inset, color: color)
    UIEdgeInsets.new.tap do |insets|
      insets.left = l_inset
      self.contentEdgeInsets = insets
    end
    setTitle(title, forState: UIControlStateNormal)
    setTitleColor(color, forState: UIControlStateNormal)
    setTitleColor(color.colorWithAlphaComponent(0.25),
                  forState: UIControlStateHighlighted | UIControlStateDisabled)
  end


  private

  def set_background_gradient(name, forState: state, colors: colors)
    img = self.class.bg_image_for(name) ||
        create_back_ground_image_for(name, colors: colors)
    setBackgroundImage(img, forState: state)
  end

  # @return [UIImage]
  def create_back_ground_image_for(name, colors: colors)
    puts "- [#{name}]用のグラデーションイメージを作ります。" if BW::debug?
    gradient = CAGradientLayer.alloc.init
    gradient.frame = self.bounds
    gradient.colors = colors

    UIGraphicsBeginImageContext(CGSizeMake(1, self.bounds.size.height))
    gradient.renderInContext(UIGraphicsGetCurrentContext())
    image = UIGraphicsGetImageFromCurrentImageContext()
    self.class.regist_image(image, for_name: name)
    image
  end

  class << self
    # @param [String] name
    # @return [UIImage]
    def bg_image_for(name)
      @bg_images ||= {}
      @bg_images[name]
    end

    # @param [UIImage] img
    # @param [String] name
    def regist_image(img, for_name: name)
      @bg_images[name] = img
    end
  end

end