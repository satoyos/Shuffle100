class BeginnerReciteLayout < RecitePoemLayout
  INITIAL_MESSAGE = 'ここに色々とメッセージを書く'

  def layout
    super
    # add UILabel, :message_label
    add MessageLabel, :message_label
  end

  def message_label_style
    text INITIAL_MESSAGE
    frame below(:header_container, down: 5)
    size ['90%', 20]
    origin x: '5%'

    background_color :dark_gray.uicolor(0.6)
    text_color :white.uicolor

    fit_to_size(14)
    text_alignment :center.nsalignment

    layer do
      corner_radius 5.5
    end
    clips_to_bounds true
  end

  def message
    get(:message_label).text
  end

  def message=(msg)
    get(:message_label).text = msg
  end
end