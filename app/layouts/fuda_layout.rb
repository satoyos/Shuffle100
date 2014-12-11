class FudaLayout < MK::Layout
  BASE_BACK_COLOR = :white.uicolor(0.8)

  attr_accessor :top_guide, :bottom_guide

  def layout
    root(:root) do
      add UIButton, :close_button
    end
  end

  def root_style
    puts '<<< in root_style of FudaLayout >>>'
    puts "self.view.height => #{height = self.view.frame.size.height}"
    background_color BASE_BACK_COLOR
    accessibility_label 'FudaLayoutView'
    width = self.view.frame.size.width
    if top_guide
      puts '- top_guide =>'
      ap top_guide
      puts '- top_guide.origin =>'
      ap top_guide.origin if top_guide
      puts '- bottom_guide =>'
      ap bottom_guide
      origin [0, 0]
      size [width, height + bottom_guide.origin.y + 20]
    end

  end

  def on_load
    puts '<<< in on_load of FudaLayout >>>'
  end

  def close_button_style
    title '閉じる'
    title_color :blue.uicolor
    size_to_fit
    frame from_top_right(down: 10, left: 5)
  end
end