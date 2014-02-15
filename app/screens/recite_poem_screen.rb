class RecitePoemScreen < PM::Screen
  include RecitePoemDataSource

  OPENING_POEM_TITLE = '序歌'
  title OPENING_POEM_TITLE

  attr_reader :supplier, :current_player, :reciting_settings

  def on_load
    init_properties_with_delegate

    init_appearance

    @rp_view = create_recite_poem_view
    add @rp_view
    recite_poem unless RUBYMOTION_ENV == 'test'
  end

  def will_appear
    top_guide_height = case self.navigationController
                         when nil; 0
                         else
                           printf "NavigationBarのフレーム: "
                           ap self.navigationController.navigationBar.frame
                           frame = self.navigationController.navigationBar.frame
                           frame.origin.y + frame.size.height
                       end
    self.recite_poem_view.layout_with_top_offset(top_guide_height)
  end

  def play_button_pushed(view)
    if @current_player.playing?
      @current_player.pause
      self.recite_poem_view.show_waiting_to_play
    else
      recite_poem
    end
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    return unless flag

    puts '- 読み上げが無事に終了！' if BW::debug?
    self.recite_poem_view.play_finished_successfully
    if @supplier.kami?
      @supplier.step_into_shimo
      goto_shimo
    else
      return unless @supplier.draw_next_poem
      goto_next_poem
    end
  end

  def recite_poem

    self.recite_poem_view.show_waiting_to_pause
    @current_player.play

  end

  def create_recite_poem_view
    rp_view = RecitePoemView.alloc.init
    rp_view.delegate = WeakRef.new(self)
    rp_view
  end

  def renew_view_and_player
    puts '== rp_viewを更新します！' if BW::debug?
    remove @rp_view
    @rp_view = create_recite_poem_view
    fetch_player

    self.will_appear
    @rp_view.layoutSubviews
 end

  def make_rp_view_appear
    add self.recite_poem_view
  end

  def fetch_player
    @current_player = @supplier.player
    @current_player.delegate = self
  end

  def recite_poem_view
    @rp_view
  end

  def current_player_progress
    total = @current_player.duration
    f = @current_player.currentTime / total
#    ap "  - f = #{f}" if BW::debug?
    f
  end

  def start_on_game_settings(sender)
    puts "Let's start On_Game_Settings!" if BW::debug?
    play_button_pushed(nil) if self.current_player.playing?

    open OnGameSettingsScreen.new, modal: true, nav_bar: true

  end

  def quit_game
    puts '- Quit Button Pushed!' if BW::debug?
#    App.alert('終了しますか？')
    if @current_player.playing?
      @current_player.pause
      self.recite_poem_view.show_waiting_to_play
    end

    BW::UIAlertView.new({
      title: '試合を終了しますか？',
      buttons: ['終了する', '続ける'],
      cancel_button_index: 0
    }) do |alert|
      if alert.clicked_button.cancel?
        puts '[quit] 試合を終了します' if BW::debug?
        # ここに試合を終えるコードを入れる。
      else
        puts '[continue] 試合を続行します' if BW::debug?
      end
    end.show
  end

  private

  def init_properties_with_delegate
    UIApplication.sharedApplication.delegate.tap do |delegate|
      @supplier = delegate.poem_supplier
      @current_player = delegate.opening_player
      @current_player.delegate = self
      @reciting_settings = delegate.reciting_settings
    end
  end

  def init_appearance
    if self.navigationController
      self.navigationController.navigationBar.topItem.prompt = AppDelegate::PROMPT
    end
    set_nav_bar_button :right, {
      title: '終了',
      action: :quit_game,
      accessibility_label: 'quit_button'
    }
  end

  def goto_shimo
    renew_view_and_player
    make_rp_view_appear
    self.recite_poem_view.show_waiting_to_play
    new_rp_view_did_appear
  end

  def goto_next_poem
    puts 'Go to Next Poem!' if BW::debug?
    renew_view_and_player
    self.recite_poem_view.show_waiting_to_play
    if RUBYMOTION_ENV == 'test'
      make_rp_view_appear
      new_rp_view_did_appear
    else
      view_animation_def('make_rp_view_appear',
                         arg: nil,
#                         duration: 1.0,
                         duration: self.reciting_settings.interval_time,
                         transition: UIViewAnimationTransitionFlipFromLeft)
    end
  end

  def new_rp_view_did_appear

    self.title = "#{@supplier.current_index}/#{@supplier.size} " +
        case @supplier.kami?
          when true ; '(上)'
          else      ; '(下)'
        end
    recite_poem if @supplier.kami?
  end

  def view_animation_def(method_name, arg: arg, duration: duration, transition: transition)
    UIView.beginAnimations(method_name, context: nil)
    UIView.setAnimationDelegate(self)
    UIView.setAnimationDuration(duration)
    if transition
      UIView.setAnimationTransition(transition,
                                    forView: self.view,
                                    cache: true)

    end
    if arg
      self.send("#{method_name}", arg)
    else
      self.send("#{method_name}")
    end
    UIView.setAnimationDidStopSelector('view_animation_has_finished:')
    UIView.commitAnimations
  end

  def view_animation_has_finished(animation_id)
    case animation_id
      when 'make_rp_view_appear'
        new_rp_view_did_appear
      else
        puts "/////// このアニメーションの後処理はありません。 ///////" if BW::debug?
    end
  end
end