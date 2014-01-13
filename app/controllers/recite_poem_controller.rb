class RecitePoemController < UIViewController
  include RecitePoemDataSource

  OPENING_POEM_TITLE = '序歌'

  attr_reader :supplier, :current_player

  def viewDidLoad
    super

    init_properties
    set_rp_view
  end

  def play_button_pushed(view)
    if @current_player.playing?
      @current_player.pause
      @rp_view.show_waiting_to_play
    else
      @current_player.play
      @rp_view.show_waiting_to_pause
    end
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    return unless flag

    puts '- 読み上げが無事に終了！'
    @rp_view.play_finished_successfully
    if @supplier.kami?
      @supplier.step_into_shimo
      goto_shimo
    else
      return unless @supplier.draw_next_poem
      goto_next_poem
    end
  end

  def recite_opening_poem
    self.title = OPENING_POEM_TITLE
    @current_player = UIApplication.sharedApplication.delegate.opening_player
    @current_player.delegate = self
    @rp_view.start_reciting
    @current_player.play
  end


  private

  def init_properties
    UIApplication.sharedApplication.delegate.tap do |delegate|
      @supplier = delegate.poem_supplier
    end
  end

  def set_rp_view
    @rp_view = RecitePoemView.alloc.initWithFrame(self.view.frame)
    @rp_view.delegate = WeakRef.new(self)
    @rp_view.dataSource = WeakRef.new(self)
    self.view.addSubview(@rp_view)
  end

  def goto_shimo
    set_rp_view
    self.title = "#{@supplier.current_index}/#{@supplier.size} (下)"
    @current_player = @supplier.player
    @current_player.delegate = self
    @rp_view.reset_time_slider
    @rp_view.show_waiting_to_play
  end

  def goto_next_poem
    puts 'Go to Next Poem!'
#    set_rp_view
    view_animation_def('set_rp_view',
                       arg: nil,
                       duration: 1.0,
                       transition: UIViewAnimationTransitionFlipFromLeft)

#    new_rp_view_did_appear
  end

  def new_rp_view_did_appear
    self.title = "#{@supplier.current_index}/#{@supplier.size} (上)"
    @current_player = @supplier.player
    @current_player.delegate = self
    @rp_view.start_reciting
    @current_player.play
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
      when 'set_rp_view'
        new_rp_view_did_appear
      else
        puts "/////// このアニメーションの後処理はありません。 ///////"
    end
  end
end