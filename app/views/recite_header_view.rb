class ReciteHeaderView < UIView
  GEAR_BUTTON_SIZE = 30
  ACC_LABEL_GEAR_BUTTON = 'gear_button'

  def initWithFrame(frame)
    super
    self.addSubview self.title_label
    self.addSubview self.gear_button
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
=begin
  def layout_subviews
    Motion::Layout.new do |layout|
#      self.title_label.sizeToFit

      layout.view self
      layout.subviews title: self.title_label
      layout.horizontal '|-(>=20)-[title]-(>=20)-|'
      layout.vertical   '|-[title(>=20)]-|'
    end

  end
=end

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
    self.frame.size.height/2 + 10
  end

  def gear_button
    @gear_button ||=
        UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
          b.setImage(gear_image, forState: UIControlStateNormal)
          b.frame = [[0, 0], [GEAR_BUTTON_SIZE, GEAR_BUTTON_SIZE]]
          b.center = CGPointMake(10 + b.frame.size.width/2,
                                 subview_center_y)
          b.addTarget(self,
                      action: 'gear_button_did_pushed:',
                      forControlEvents: UIControlEventTouchUpInside)
          b.accessibilityLabel = ACC_LABEL_GEAR_BUTTON
        end
  end

  def gear_button_did_pushed(sender)
    superview.delegate.start_on_game_settings(sender)
  end

  def gear_image
    ResizeUIImage.resizeImage(UIImage.imageNamed('gear_256.png'),
                              newSize: CGSizeMake(GEAR_BUTTON_SIZE, GEAR_BUTTON_SIZE))
  end


end