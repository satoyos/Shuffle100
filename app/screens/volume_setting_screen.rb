class VolumeSettingScreen < PM::Screen
  PLAY_BUTTON_TITLE = 'テスト音声を再生する'

  attr_reader :test_player
  # attr_reader :volume

  def on_load
    set_test_player

    self.view = UIScrollView.alloc.initWithFrame(self.view.bounds)
    self.view.backgroundColor = UIColor.whiteColor
    self.title = '音量の調整'

    # self.view.addSubview self.interval_label
    # self.view.addSubview self.blank_label
    # self.view.addSubview self.sec_label
    self.view.addSubview self.play_button
    self.view.addSubview self.volume_slider
  end

  def will_appear
    # 以下、レイアウト
    Motion::Layout.new do |layout|

      layout.view self.view
      layout.subviews 'slider'    => self.volume_slider,
                      'button'    => self.play_button
                      # 'int_label' => self.interval_label,
                      # 'blank'     => self.blank_label,
                      # 'sec_label' => self.sec_label
      layout.metrics 'margin' => 20, 'height' => 40
                     # 'top_margin' => top_guide_height + 50,
                     # 'il_height' => quarter_height

      layout.vertical(
          # '|-(<=top_margin)-[int_label][blank(<=height)]-margin-[slider(blank)]-[button(blank)]-(<=margin@600)-|'
          '|-(margin)-[slider(height)]-(margin)-[button(height)]|'
      )

      layout.horizontal '|-[slider]-|'
      # layout.horizontal '[button(slider)]'
    end
    # volume_sliderのcenterXを、self.viewのcenterXと一致させる
    self.view.addConstraint(
        NSLayoutConstraint.constraintWithItem( self.volume_slider,
                                               attribute: NSLayoutAttributeCenterX,
                                               relatedBy: NSLayoutRelationEqual,
                                               toItem: self.view,
                                               attribute: NSLayoutAttributeCenterX,
                                               multiplier: 1,
                                               constant: 0 )
    )
  end

  def will_disappear
    puts ' - interval_timeの値を %1.2f秒に書き換えます！' % self.volume_slider.value if BW::debug?
    app_delegate.reciting_settings.volume = self.volume_slider.value.round(2)
  end

  def should_autorotate
    false
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    return unless flag

    puts '- 読み上げが無事に終了！' if BW::debug?
    reset_player
    self.play_button.enabled = true
  end



  def play_button
    @play_button ||=
        UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
          b.setTitle(PLAY_BUTTON_TITLE, forState: UIControlStateNormal)
          b.addTarget(self, action: 'play_button_pushed:',
                      forControlEvents: UIControlEventTouchUpInside)
        end
  end

  def volume_slider
    @volume_slider ||=
        UISlider.alloc.initWithFrame(CGRectZero).tap do  |sl|
          sl.value = app_delegate.reciting_settings.volume
          sl.addTarget(self, action: 'sliderChanging:',
                       forControlEvents: UIControlEventValueChanged)
          sl.addTarget(self, action: 'slider_value_changed:',
                       forControlEvents: UIControlEventTouchUpInside |
                           UIControlEventTouchUpOutside)
        end
  end

  def sliderChanging(sender)
#    reset_player_if_needed
    test_player.volume = sender.value

  end

  def slider_value_changed(sender)
#    reset_player_if_needed #これをSliderの値が変わるたびに呼ぶと、実機で重くなるので注意！
    puts "- スライダーの値は #{self.volume_slider.value}" if BW::debug?
    test_player.volume = sender.value
  end



  private

  def play_button_pushed(button)
    puts "button #{button} is pushed" if BW::debug?
    puts "このとき、スライダーの値は[#{self.volume_slider.value}]" if BW::debug?
    reset_player
#    @volume = self.volume_slider.value
    test_player.play
    play_button.enabled = false
  end


  def set_test_player
    supplier = PoemSupplier.new
    supplier.draw_next_poem
    @test_player = supplier.player.tap do |player|
      player.delegate = self
      player.volume = app_delegate.reciting_settings.volume
    end
  end

  def reset_player
#    test_player.pause if player.playing?
    test_player.currentTime = 0.0
    test_player.prepareToPlay
    play_button.enabled = true
  end


end
