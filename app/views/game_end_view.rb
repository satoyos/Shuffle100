class GameEndView < UIView
  GAME_END_VIEW_TITLE =  '試合終了'
  HEADER_VIEW_HEIGHT = RecitePoemView::HEADER_VIEW_HEIGHT

  attr_accessor :delegate

  def initWithFrame(frame)
    super
    self.backgroundColor= UIColor.whiteColor
    self.addSubview self.back_to_top_button
    self.addSubview self.header_view

    self
  end


  def back_to_top_button
    @back_to_top_button ||=
        UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
          b.frame = [[0, 0], [200, 80]]
          b.center = self.center
          b.setTitle('トップに戻る', forState: UIControlStateNormal)
          b.addTarget(self,
                      action: :back_to_top_button_pushed,
                      forControlEvents: UIControlEventTouchUpInside)
        end
  end

  def back_to_top_button_pushed
    puts '[Back to Top] button pushed!' if BW::debug?

    #%ToDo: ここ、delegateのメッセージを呼び出すように実装する！
  end

  def header_view
    @header_view ||=
        ReciteHeaderView.alloc.initWithFrame(header_view_frame).tap do |view|
          view.title = GAME_END_VIEW_TITLE
        end
  end

  def header_view_frame
    [[0, 0],
     [self.frame.size.width, HEADER_VIEW_HEIGHT]]
  end
end