class GameEndLayout < MotionKit::Layout
  include NormalButtonStyles

  weak_attr :delegate

  def layout
    background_color :white.uicolor
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
    set_button_title_color
    size ['50%', '30%']
    center ['50%', '50%']
    accessibility_label 'back_to_top'
  end


  def add_back_to_button_action
    return unless delegate
    get(:back_to_top_button).addTarget(delegate,
                                       action: 'back_to_top_screen',
                                       forControlEvents: UIControlEventTouchUpInside)
  end
end