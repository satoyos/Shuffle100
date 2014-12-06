# class GameStartCell < UITableViewCell
class GameStartCell < PM::TableViewCell
  CELL_STYLE = UITableViewCellStyleDefault
  CELL_ACCESSORY = UITableViewCellAccessoryNone

  def initWithText(text, acc_label: acc_label, reuseIdentifier: reuseIdentifier)
    self.initWithStyle(CELL_STYLE, reuseIdentifier: reuseIdentifier)
    textLabel.text = text
    self.accessibilityLabel = acc_label

    self
  end

  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super
    set_style
    self
  end

  def on_reuse
    set_style
  end

  def set_style
    textLabel.textAlignment = UITextAlignmentCenter
    textLabel.textColor = UIColor.redColor
  end
end