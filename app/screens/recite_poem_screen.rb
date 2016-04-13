class RecitePoemScreen < PM::Screen
  include RecitePoemDataSource
  include RecitePoemDelegate
  include OH::Notifications
  include ReciteAnimationAndPlayer
  include RecitePoemDriveScreen

  attr_reader :supplier, :current_player, :reciting_settings
  attr_reader :layout

  title 'This title should not appear!'

  def on_load
    init_properties_with_delegate
    init_view_with_new_layout
    recite_poem
    set_font_changed_notification
  end

  def on_appear
    layout.show_opening_notice_if_needed
  end

  def on_return(args={})
    puts '// 読み上げ画面に帰ってきたぜ！' if BW2.debug?
    set_player_volume
  end

  def should_autorotate
    false
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    return unless flag

    puts '- 読み上げが無事に終了！' if BW2.debug?
    layout.play_finished_successfully
    if supplier.kami?
      supplier.step_into_shimo
      transit_kami_shimo
    else
      recite_next_poem_without_pause
    end
  end

  def font_changed(notification)
    layout.font_changed(notification)
  end

  def poem
    supplier.poem
  end

  private

  def recite_poem
    return if RUBYMOTION_ENV == 'test'
    layout.show_waiting_to_pause
    set_player_volume
    current_player.play
  end

  def init_view_with_new_layout
    view.backgroundColor = AppDelegate::BAR_TINT_COLOR # 見えてはいけないviewが見えたらすぐ分かるよう着色
    create_new_layout
    add layout.view
  end

  def create_new_layout
    @layout = RecitePoemLayout.create_with_delegate(self, sizes: get_sizes)
    set_button_actions
  end

  def get_sizes
    app_delegate.sizes ? app_delegate.sizes :
        OH::DeviceSizeManager.select_sizes # こっちはRSpecテスト用
  end

  def init_properties_with_delegate
    app_delegate.tap do |delegate|
      @supplier = delegate.poem_supplier
      @current_player = delegate.opening_player.tap do |player|
        player.delegate = self
        player.currentTime = 0.0
        player.prepareToPlay
      end
      @reciting_settings = delegate.reciting_settings
    end
  end

  def set_button_actions
    set_button_of_symbol(:gear_button, action: 'open_on_game_settings:')
    set_button_of_symbol(:quit_button, action: 'quit_game')
    set_button_of_symbol(:play_button, action: 'play_button_pushed:')
    set_button_of_symbol(:forward_button, action: 'forward_skip')
    set_button_of_symbol(:rewind_button, action: 'rewind_skip')
  end

  def set_button_of_symbol(sym, action: action_str)
    layout.get(sym).addTarget(self,
                              action: action_str,
                              forControlEvents: UIControlEventTouchUpInside)
  end

  def renew_layout_and_player
    puts '== LayoutとPlayerを更新します！' if BW2.debug?
    create_new_layout
    fetch_player
  end

  def create_current_title
    "#{@supplier.current_index}首め:" +
        (@supplier.kami? ? '上の句' : '下の句') +
        " (全#{@supplier.size}首)"
  end
end