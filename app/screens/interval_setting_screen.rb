class IntervalSettingScreen < PM::Screen
  MIN_INTERVAL_VALUE = 0.5
  MAX_INTERVAL_VALUE = 2.0
  SHORTEN_INTERVAL = 0.02

  TRY_BUTTON_TITLE = '試しに聞いてみる'

  attr_reader :shimo_player, :kami_player, :interval_time

  def on_load
    set_kami_shimo_players

    self.view.backgroundColor = UIColor.whiteColor
    self.title = '歌の間隔の変更'

    self.view.addSubview self.interval_label
    self.view.addSubview self.blank_label
    self.view.addSubview self.sec_label
    self.view.addSubview self.try_button
    self.view.addSubview self.interval_slider
  end

  def will_appear
    printf 'このViewのサイズ: ' if BW::debug?
    ap self.view.frame.size if BW::debug?

    top_guide_height = case self.navigationController
                         when nil; 0
                         else
                           printf "NavigationBarのフレーム: " if BW::debug?
                           ap self.navigationController.navigationBar.frame if BW::debug?
                           frame = self.navigationController.navigationBar.frame
                           frame.origin.y + frame.size.height
                       end

    puts "計算したTopLayoutGuide.length相当の値 => #{top_guide_height}" if BW::debug?


    # 以下、レイアウト
    Motion::Layout.new do |layout|

      layout.view self.view
      layout.subviews 'slider'    => self.interval_slider,
                      'button'    => self.try_button,
                      'int_label' => self.interval_label,
                      'blank'     => self.blank_label,
                      'sec_label' => self.sec_label
      layout.metrics 'margin' => 20, 'height' => 40,
                     'top_margin' => top_guide_height + 50,
                     'il_height' => quarter_height

      layout.vertical(
          '|-(<=top_margin)-[int_label][blank(<=height)]-margin-[slider(blank)]-[button(blank)]-(<=margin@600)-|'
      )
#      layout.horizontal '[int_label(200)]'
      layout.horizontal '[blank(int_label)]'
      layout.horizontal '[blank][sec_label(40)]-(>=margin)-|'
      layout.horizontal '|-margin-[slider]-margin-|'
      layout.horizontal '|-margin-[button]-margin-|'
#      layout.vertical '[int_label(il_height)][sec_label(height)]'
    end

    # interval_labelのcenterXを、self.viewのcenterXと一致させる
    self.view.addConstraint(
        NSLayoutConstraint.constraintWithItem( self.interval_label,
                                               attribute: NSLayoutAttributeCenterX,
                                               relatedBy: NSLayoutRelationEqual,
                                               toItem: self.view,
                                               attribute: NSLayoutAttributeCenterX,
                                               multiplier: 1,
                                               constant: 0 )
    )
    # interval_labelの縦横比を1:2にする
    self.interval_label.addConstraint(
        NSLayoutConstraint.constraintWithItem( self.interval_label,
                                               attribute: NSLayoutAttributeHeight,
                                               relatedBy: NSLayoutRelationEqual,
                                               toItem: self.interval_label,
                                               attribute: NSLayoutAttributeWidth,
                                               multiplier: 0.5,
                                               constant: 0 )
    )

    # interval_labelのテキストを設定
    @interval_label.font = @interval_label.font.fontWithSize(quarter_height)
    update_interval_label_text

  end

  def will_disappear
    puts ' - interval_timeの値を %1.2f秒に書き換えます！' % self.interval_slider.value if BW::debug?
    app_delegate.reciting_settings.interval_time = self.interval_slider.value.round(2)
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    return unless flag

    puts '- 読み上げが無事に終了！' if BW::debug?
    if @kami_playing
      update_interval_label_text
      return
    end

    puts "- #{self.interval_time}秒間の間隔を開けます。" if BW::debug?
    @last_time = self.interval_time

    NSLog '  - Timer Start!' if BW::debug?
    NSTimer.scheduledTimerWithTimeInterval(SHORTEN_INTERVAL,
                                           target: self,
                                           selector: 'shorten_last_time:',
                                           userInfo: nil,
                                           repeats: true)
  end

  def shorten_last_time(timer)
    @last_time -= SHORTEN_INTERVAL
    self.interval_label.text = '%.02f' % @last_time
    if @last_time < SHORTEN_INTERVAL
      timer.invalidate
      self.interval_label.text = '%.02f' % 0.0
      NSLog '  - Timer END!' if BW::debug?
      self.kami_player.play
      @kami_playing = true
    end

  end

  def interval_label
    unless @interval_label
      @interval_label = UILabel.alloc.initWithFrame(CGRectZero).tap do |l|
        l.textAlignment = UITextAlignmentCenter
        l.adjustsFontSizeToFitWidth = true
      end
    end
    @interval_label
  end

  def blank_label
    unless @blank_label
      @blank_label = UILabel.alloc.initWithFrame(CGRectZero)
    end
    @blank_label
  end

  def sec_label
    unless @sec_label
      @sec_label = UILabel.alloc.initWithFrame(CGRectZero).tap do |l|
        l.font = l.font.fontWithSize(20)
        l.textAlignment =UITextAlignmentCenter
        l.text = '秒'
      end
    end
    @sec_label
  end


  def try_button
    unless @try_button
      @try_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
        b.setTitle(TRY_BUTTON_TITLE, forState: UIControlStateNormal)
        b.addTarget(self, action: 'try_button_pushed:',
                    forControlEvents: UIControlEventTouchUpInside)
      end
    end
    @try_button
  end

  def interval_slider
    unless @interval_slider
      @interval_slider = UISlider.alloc.initWithFrame(CGRectZero)
      @interval_slider.tap do  |sl|
        sl.minimumValue = MIN_INTERVAL_VALUE
        sl.maximumValue = MAX_INTERVAL_VALUE
        sl.value = app_delegate.reciting_settings.interval_time
        sl.addTarget(self, action: 'sliderChanging:',
                     forControlEvents: UIControlEventValueChanged)
        sl.addTarget(self, action:'slider_value_changed:',
                     forControlEvents: UIControlEventTouchUpInside |
                         UIControlEventTouchUpOutside)

      end
    end
    @interval_slider
  end

  def sliderChanging(sender)
    reset_players_if_needed
    sender.value = sender.value.round(2)
    update_interval_label_text
  end

  def slider_value_changed(sender)
    reset_players #これをSliderの値が変わるたびに呼ぶと、実機で重くなるので注意！
    puts "- スライダーの値は #{self.interval_slider.value}" if BW::debug?
    update_interval_label_text
  end

  def update_interval_label_text
    self.interval_label.text = '%.02f' % self.interval_slider.value
  end

  private

  def try_button_pushed(button)
    puts "button #{button} is pushed" if BW::debug?
    puts "このとき、スライダーの値は[#{self.interval_slider.value}]" if BW::debug?
    reset_players_if_needed
    @interval_time = self.interval_slider.value.round(2)
    self.shimo_player.play
    @kami_playing = false
  end

  def quarter_height
    (self.view.frame.size.height / 4).to_i
  end


  def set_kami_shimo_players
    supplier = PoemSupplier.new  # 間隔調節用に、全く新規のsupplierを作る
    supplier.draw_next_poem
    supplier.step_into_shimo
    @shimo_player = supplier.player # 一首目の下の句を再生するプレーヤー
    @shimo_player.delegate = self

    supplier.draw_next_poem
    @kami_player = supplier.player  # 二首目の下の句を再生するプレーヤー
    @kami_player.delegate = self
  end

  def reset_players_if_needed
    return unless self.kami_player.playing? or self.shimo_player.playing?
    reset_players
  end

  def reset_players
    reset_player self.kami_player
    reset_player self.shimo_player
  end

  # @param [AVAudioPlayer] player
  def reset_player(player)
    player.pause if player.playing?
    player.currentTime = 0.0
    player.prepareToPlay
  end



end
