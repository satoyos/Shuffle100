class RecitePoemScreen < PM::Screen
  include RecitePoemDataSource
  include RecitePoemDelegate


  OPENING_POEM_TITLE = '序歌'
  title OPENING_POEM_TITLE

  attr_reader :supplier, :current_player, :reciting_settings

  def on_load
    init_properties_with_delegate

    @rp_view = create_recite_poem_view
    self.recite_poem_view.title = OPENING_POEM_TITLE
    add @rp_view
    recite_poem unless RUBYMOTION_ENV == 'test'

  end

  def will_appear
    top_guide_height = case self.navigationController
                         when nil; 0
                         else
                           frame = self.navigationController.navigationBar.frame
                           frame.origin.y + frame.size.height
                       end
    self.recite_poem_view.layout_with_top_offset(top_guide_height)
  end

  def should_autorotate
    false
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    return unless flag

    puts '- 読み上げが無事に終了！' if BW::debug?
    self.recite_poem_view.play_finished_successfully
    if @supplier.kami?
      @supplier.step_into_shimo
      transit_kami_shimo(true)
    else
      if @supplier.draw_next_poem # 次の歌がある
        goto_next_poem
      else                        # 次の歌がない (最後の歌だった)
        @rp_view = GameEndView.alloc.initWithFrame(bounds).tap do |ge_view|
          ge_view.delegate = WeakRef.new(self)
        end
        view_animation_def('make_rp_view_appear',
                           arg: nil,
                           duration: self.reciting_settings.interval_time,
                           transition: UIViewAnimationTransitionFlipFromLeft)
      end
    end
  end

  def recite_poem

    self.recite_poem_view.show_waiting_to_pause
    @current_player.play

  end

  def create_recite_poem_view
#    rp_view = RecitePoemView.alloc.initWith
    rp_view = RecitePoemView.alloc.initWithFrame(view.frame)
    rp_view.delegate = WeakRef.new(self)
    rp_view.title = create_current_title
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

  private

  def init_properties_with_delegate
    UIApplication.sharedApplication.delegate.tap do |delegate|
      delegate.refresh_models
      @supplier = delegate.poem_supplier
      @current_player = delegate.opening_player
      @current_player.delegate = self
      @reciting_settings = delegate.reciting_settings
    end
  end

  def go_back_to_kami
    transit_kami_shimo(false)
  end

  def transit_kami_shimo(to_recite)
    renew_view_and_player
    make_rp_view_appear
    self.recite_poem_view.show_waiting_to_play
    new_rp_view_did_appear(to_recite)
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
                         duration: self.reciting_settings.interval_time,
                         transition: UIViewAnimationTransitionFlipFromLeft)
    end
  end

  def go_back_to_prev_poem
    puts 'Back to Prev Poem!' if BW::debug?
    renew_view_and_player
    self.recite_poem_view.show_waiting_to_play
    if RUBYMOTION_ENV == 'test'
      make_rp_view_appear
      new_rp_view_did_appear(false)
    else
      view_animation_def('make_rp_view_appear',
                         arg: nil,
                         duration: 0.5,
                         transition: UIViewAnimationTransitionFlipFromRight)
    end
  end

  def new_rp_view_did_appear(to_recite=true)
    recite_poem if @supplier.kami? and to_recite
  end


  def create_current_title
    "#{@supplier.current_index}/#{@supplier.size} " +
        case @supplier.kami?
          when true; '(上)'
          else     ; '(下)'
        end
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