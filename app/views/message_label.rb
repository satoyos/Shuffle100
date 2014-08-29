class MessageLabel < UILabel
  def drawTextInRect(rect)
    insets = UIEdgeInsetsMake(0, 5, 0, 5)
    super(UIEdgeInsetsInsetRect(rect, insets))
  end
end