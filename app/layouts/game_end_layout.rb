class GameEndLayout < MotionKit::Layout
  GAME_END_VIEW_TITLE =  '試合終了'
  BACK_TO_TOP_TITLE = 'トップに戻る'
  ACC_LABEL_BACK_TO_TOP_BUTTON = 'back_to_top'

  weak_attr :delegate

  def layout
    background_color 'white'.to_color
    add UIView, :header do
      add UILabel, :title_label
    end
    add UIButton, :back_to_top_button
  end

  def header_style
    background_color AppDelegate::BAR_TINT_COLOR
    size ['100%', RecitePoemStyles::HEADER_HEIGHT]
  end

  def title_label_style
    text '試合終了'
    size_to_fit
    center ['50%', '50%']
  end

  def back_to_top_button_style
    title 'トップに戻る'
    title_color 'blue'.to_color
    title_color 'lightGray'.to_color, state: UIControlStateHighlighted
    size ['50%', '30%']
    center ['50%', '50%']
  end


  def add_back_to_button_action
    return unless delegate
    get(:back_to_top_button).addTarget(delegate,
                                       action: 'back_to_top_screen',
                                       forControlEvents: UIControlEventTouchUpInside)
  end
end