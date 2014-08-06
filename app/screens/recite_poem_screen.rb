class RecitePoemScreen < PM::Screen
  include RecitePoemAnimation
  include RecitePoemDataSource
  include RecitePoemDelegate

  OPENING_POEM_TITLE = '序歌'
  SLIDING_EFFECT_DURATION = 0.2
  ANIME_STOP_SELECTOR = 'view_animation_has_finished:'

  attr_reader :supplier, :current_player, :reciting_settings
  attr_reader :layout

  title OPENING_POEM_TITLE

  def on_load
    init_properties_with_delegate

    view.backgroundColor = AppDelegate::BAR_TINT_COLOR # 見えてはいけないviewが見えたらすぐ分かるよう着色
    create_new_layout
    add layout.view
    recite_poem unless RUBYMOTION_ENV == 'test'
  end

  def on_return
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
      if supplier.draw_next_poem # 次の歌がある
        goto_next_poem
      else                        # 次の歌がない (最後の歌だった)
        end_of_the_game
      end
    end
  end

   def recite_poem
    layout.show_waiting_to_pause
    set_player_volume
    current_player.play
  end

  private

  def create_new_layout
    @layout = RecitePoemLayout.new.tap{|l| l.delegate = self}
    set_button_actions
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

  def fetch_player
    @current_player = @supplier.player
    current_player.delegate = self
    set_player_volume
  end

  def renew_layout_and_player
    puts '== LayoutとPlayerを更新します！' if BW2.debug?
    create_new_layout
    fetch_player
  end

  def set_player_volume
    current_player.volume = app_delegate.reciting_settings.volume
  end

  def transit_kami_shimo
    recite_view_slide_in_from(:right)
  end

  def transit_shimo_kami
    recite_view_slide_in_from(:left)
  end

  def recite_view_slide_in_from(location)
    prev_view = view.subviews.first
    renew_layout_and_player
    layout.show_waiting_to_play
    layout.title = create_current_title
    add layout.view
    layout.locate_view(location)
    UIView.animateWithDuration(SLIDING_EFFECT_DURATION, animations: lambda{
      layout.locate_view(:normal)
    }, completion: lambda{|finished|
      remove prev_view
    })

  end

  def goto_next_poem
    puts 'Go to Next Poem!' if BW2.debug?
    renew_layout_and_player
    layout.show_waiting_to_play
    layout.title = create_current_title
    next_poem_flip_animate(reciting_settings.interval_time,
                           stop_selector: ANIME_STOP_SELECTOR){
      remove view.subviews.first
      add layout.view
    }
  end

  def end_of_the_game
    @layout = GameEndLayout.new.tap{|l| l.delegate = self}
    layout.add_back_to_button_action
    game_end_flip_animate(reciting_settings.interval_time,
                          stop_selector: ANIME_STOP_SELECTOR){
      remove view.subviews.first
      add layout.view
    }
  end

  def go_back_to_prev_poem
    puts 'Back to Prev Poem!' if BW2.debug?
    renew_layout_and_player
    layout.show_waiting_to_play
    layout.title = create_current_title
    prev_poem_flip_animate(0.5, stop_selector: ANIME_STOP_SELECTOR){
      remove view.subviews.first
      add layout.view
    }
  end

  def create_current_title
    "#{@supplier.current_index}首め:" +
        case @supplier.kami?
          when true; '上の句'
          else     ; '下の句'
        end +
        " (全#{@supplier.size}首)"
  end

  def view_animation_has_finished(animation_id)
    case animation_id
      when ID_NEXT_POEM_FLIP
        recite_poem
      else
        puts "/////// このアニメーションの後処理はありません。 ///////" if BW2.debug?
    end
  end
end