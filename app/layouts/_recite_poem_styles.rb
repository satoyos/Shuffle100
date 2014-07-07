module RecitePoemStyles
  def progress_bar_style
    # progress_view_style UIProgressViewStyleDefault

    # MotionKitのバグかどうか分からないけど、
    # ここでProgressViewの高さを指定しても、2pt固定になる。
    size ['100% - 80', 10]
    center ['50%', '50%']
  end
end