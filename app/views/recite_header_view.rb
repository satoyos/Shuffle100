class ReciteHeaderView < UIView
  PROMPT_HEIGHT = 20
  GEAR_BUTTON_SIZE = 30
  BUTTON_IMAGE_SIZE = CGSizeMake(30, 30)
  BUTTON_WIDTH = 40
  ACC_LABEL_GEAR_BUTTON = 'gear_button'
  ACC_LABEL_QUIT_BUTTON = 'quit_button'

  def initWithFrame(frame)
    super
    self.backgroundColor = AppDelegate::BAR_TINT_COLOR
    self.addSubview self.title_label
    self.addSubview self.gear_button
    self.addSubview self.quit_button
    self
  end

  def title=(str)
    self.title_label.tap do |l|
      l.text = str
      l.sizeToFit
      l.center = CGPointMake(self.frame.size.width/2,
                             subview_center_y)
    end
  end

  def title
    self.title_label.text
  end

  def title_label
    @title_label ||=
        UILabel.alloc.initWithFrame(CGRectZero).tap do |l|
          l.text = '進捗ラベル'
          l.sizeToFit
          l.center = CGPointMake(self.frame.size.width/2,
                                 subview_center_y)
        end
  end

  def subview_center_y
    (self.frame.size.height + PROMPT_HEIGHT) / 2
  end

  def gear_button
    @gear_button ||=
        UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
          b.contentEdgeInsets = button_insets
          b.setImage(gear_image, forState: UIControlStateNormal)
          b.frame = [[0, PROMPT_HEIGHT], button_size]
          b.addTarget(self,
                      action: 'gear_button_did_pushed:',
                      forControlEvents: UIControlEventTouchUpInside)
          b.accessibilityLabel = ACC_LABEL_GEAR_BUTTON
        end
  end

  def quit_button
    @quit_button ||=
        UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
          b.contentEdgeInsets = button_insets
          b.setImage(quit_image, forState: UIControlStateNormal)
          b.frame = [[self.frame.size.width - BUTTON_WIDTH, PROMPT_HEIGHT], button_size]
          b.addTarget(self,
                      action: 'quit_button_did_pushed:',
                      forControlEvents: UIControlEventTouchUpInside)
          b.accessibilityLabel = ACC_LABEL_QUIT_BUTTON
        end
  end

  def button_insets
    UIEdgeInsets.new.tap do |insets|
      insets.top = insets.bottom = insets.left = insets.right = 8
    end
  end

  def gear_button_did_pushed(sender)
    superview.delegate.open_on_game_settings(sender)
  end

  def quit_button_did_pushed(sender)
    puts '- quit button clikced in Header!' if BW::debug?
    superview.delegate.quit_game
  end

  def gear_image
    UIImage.imageNamed('gear-520.png')
  end

  def quit_image
    UIImage.imageNamed('exit_square_org.png')
  end

  def button_size
    CGSizeMake(BUTTON_WIDTH, self.frame.size.height - PROMPT_HEIGHT)
  end



end