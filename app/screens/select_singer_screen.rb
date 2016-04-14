class SelectSingerScreen < PM::Screen
  include InitPickerView
  include SelectSingerScreenDelegate

  title '読手を選ぶ'

  attr_reader :singers, :picker_view, :try_button, :player

  def on_load
    init_base_view
    fetch_singers
    set_picker_view
    set_try_button
  end

  def will_appear
    self.navigationItem.prompt = app_delegate.prompt
    picker_view.selectRow(app_delegate.game_settings.singer_index,
                          inComponent: COMPONENT_ID,
                          animated: false)
  end

  def will_disappear
    app_delegate.game_settings.singer_index = current_singer_id
    app_delegate.settings_manager.save
  end

  def should_autorotate
    false
  end

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def pickerView(pickerView, numberOfRowsInComponent: component)
    singers.size
  end

  private

  def init_base_view
    view.backgroundColor = :white.uicolor
  end

  def fetch_singers
    @singers = Singer.singers
  end

  # PICKER_VIEW_ACC_LABEL = 'picker_view'
  # COMPONENT_ID = 0

  def set_try_button
    @try_button = UIButton.alloc.init.tap do |b|
      b.title = '試しに聞いてみる'
      b.sizeToFit
      b.frame = [
          [0, picker_view.frame.size.height + 20],
          [view.frame.size.width, b.frame.size.height]
      ]
      b.setTitleColor(:blue.uicolor, forState: :normal.uicontrolstate)
      b.setTitleColor(:red.uicolor,  forState: :highlighted.uicontrolstate)
      b.setTitleColor(:light_gray.uicolor,  forState: :disabled.uicontrolstate)
      b.on(:touch){play_current_singer}
      view.addSubview(b)
    end
  end

  def play_current_singer
    puts "++ #{current_singer.name}の声で読みます" if BW2.debug?
    path = current_singer.path + '/001a'
    @player = AudioPlayerFactory.create_player_by_path(path, ofType: 'm4a').tap do |p|
      p.volume = app_delegate.reciting_settings.volume
      p.delegate = self
      p.prepareToPlay
    end
    player.play
  end

  def current_singer
    singers[current_singer_id]
  end

  def current_singer_id
    picker_view.selectedRowInComponent(COMPONENT_ID)
  end

end