class GameStartCell < UITableViewCell
  CELL_STYLE = UITableViewCellStyleDefault
  CELL_ACCESSORY = UITableViewCellAccessoryNone

  def initWithText(text, acc_label: acc_label, reuseIdentifier: reuseIdentifier)
    self.initWithStyle(CELL_STYLE, reuseIdentifier: reuseIdentifier)
    textLabel.text = text
#    textLabel.textAlignment = UITextAlignmentCenter
#    textLabel.textColor = UIColor.redColor
    self.accessibilityLabel = acc_label

    self
  end

  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super

    textLabel.textAlignment = UITextAlignmentCenter
    textLabel.textColor = UIColor.redColor

    self
  end
end