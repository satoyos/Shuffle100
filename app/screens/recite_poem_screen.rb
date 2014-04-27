class RecitePoemScreen < PM::Screen
  include RecitePoemDataSource
  include RecitePoemDelegate

  OPENING_POEM_TITLE = '序歌'
  SLIDING_EFFECT_DURATION = 0.2
  title OPENING_POEM_TITLE

  attr_reader :supplier, :current_player, :reciting_settings

  def on_load
    init_properties_with_delegate

    view.backgroundColor = UIColor.redColor # 見えてはいけないviewが見えたらすぐ分かるよう着色
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

  def on_return
    puts '// 読み上げ画面に帰ってきたぜ！' if BW::debug?
    set_player_volume
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
        @rp_view =
            GameEndView.alloc.initWithFrame(bounds,
                                            header_height: @rp_view.header_height).tap do |ge_view|
              ge_view.delegate = WeakRef.new(self)
            end
        view_animation_def('make_rp_view_appear_adding',
                           arg: nil,
                           duration: self.reciting_settings.interval_time,
                           transition: UIViewAnimationTransitionFlipFromLeft)
      end
    end
  end

  def recite_poem
    self.recite_poem_view.show_waiting_to_pause
    set_player_volume
    @current_player.play

  end

  def create_recite_poem_view
    RecitePoemView.alloc.initWithFrame(view.frame).tap do |rp_view|
      rp_view.delegate = self
      rp_view.title = create_current_title
      rp_view.show_waiting_to_play
    end
  end

  def renew_view_and_player(side = nil)
    puts '== rp_viewを更新します！' if BW::debug?
    @prev_view = @rp_view
    @rp_view = create_recite_poem_view
    fetch_player

    self.will_appear
    @rp_view.layoutSubviews

    locate_rp_view(side)
 end

  def locate_rp_view(side)
    case side
      when :right
        @rp_view.frame = [[frame.size.width, 0], frame.size]
      when :left
        @rp_view.frame = [[-1 * frame.size.width, 0], frame.size]
      else
        # 何もしない
    end
  end

  def make_rp_view_appear_adding
    add self.recite_poem_view
  end

  def make_rp_view_appear_sliding
    @rp_view.frame = [[0, 0], frame.size]
  end

  def fetch_player
    @current_player = @supplier.player
    @current_player.delegate = self
    set_player_volume
  end

  def recite_poem_view
    @rp_view
  end

  private

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

  def set_player_volume
    @current_player.volume = app_delegate.reciting_settings.volume
  end

  def go_back_to_kami
    transit_shimo_kami(false)
  end

  def transit_kami_shimo(to_recite)
    renew_view_and_player(:right)
    make_view_appear_with_sliding
  end

  def transit_shimo_kami(to_recite)
    renew_view_and_player(:left)
    make_view_appear_with_sliding
  end

  def make_view_appear_with_sliding
    add self.recite_poem_view
    view_animation_def('make_rp_view_appear_sliding', arg: nil,
                       duration: SLIDING_EFFECT_DURATION, transition: nil)
  end


  def goto_next_poem
    puts 'Go to Next Poem!' if BW::debug?
    renew_view_and_player
    self.recite_poem_view.show_waiting_to_play
    view_animation_def('make_rp_view_appear_adding',
                       arg: nil,
                       duration: self.reciting_settings.interval_time,
                       transition: UIViewAnimationTransitionFlipFromLeft)
  end

  def go_back_to_prev_poem
    puts 'Back to Prev Poem!' if BW::debug?
    renew_view_and_player
    self.recite_poem_view.show_waiting_to_play
    view_animation_def('make_rp_view_appear_adding',
                       arg: nil,
                       duration: 0.5,
                       transition: UIViewAnimationTransitionFlipFromRight)
  end

  def new_rp_view_did_appear(to_recite=true)
    if @prev_view
      remove @prev_view
      @prev_view = nil
    end
    recite_poem if @supplier.kami? and to_recite
  end


  def create_current_title
    "#{@supplier.current_index}首め:" +
        case @supplier.kami?
          when true; '上の句'
          else     ; '下の句'
        end +
        " (全#{@supplier.size}首)"

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
      when 'make_rp_view_appear_adding'
        new_rp_view_did_appear(true)
      when 'make_rp_view_appear_sliding'
        new_rp_view_did_appear(false)
      else
        puts "/////// このアニメーションの後処理はありません。 ///////" if BW::debug?
    end
  end
end