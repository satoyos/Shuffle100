module RecitePoemDriveScreen
  ANIME_STOP_SELECTOR = 'view_animation_has_finished:'

  private

  def go_back_to_prev_poem
    puts 'Back to Prev Poem!' if BW2.debug?
    renew_layout_and_player
    layout.show_waiting_to_play
    layout.title = create_current_title
    prev_poem_flip_animate(0.5, stop_selector: ANIME_STOP_SELECTOR) {
      remove view.subviews.first
      add layout.view
    }
  end

  def end_of_the_game
    @layout = GameEndLayout.new.tap { |l| l.delegate = self }.build
    layout.get(:back_to_top_button).on(:touch) { back_to_top_screen }
    game_end_flip_animate(reciting_settings.interval_time,
                          stop_selector: ANIME_STOP_SELECTOR) {
      remove view.subviews.first
      add layout.view
    }
  end

  def goto_next_poem
    puts 'Go to Next Poem!' if BW2.debug?
    renew_layout_and_player
    layout.show_waiting_to_play
    layout.title = create_current_title
    next_poem_flip_animate(reciting_settings.interval_time,
                           stop_selector: ANIME_STOP_SELECTOR) {
      remove view.subviews.first
      add layout.view
    }
  end

  def recite_next_poem_without_pause
    if supplier.draw_next_poem # 次の歌がある
      goto_next_poem
    else # 次の歌がない (最後の歌だった)
      end_of_the_game
    end
  end
end
