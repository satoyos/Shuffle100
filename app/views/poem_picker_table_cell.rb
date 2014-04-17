class PoemPickerTableCell < PM::TableViewCell
  def layoutSubviews
    layout do
      self.textLabel.font = UIFont.fontWithName('HiraMinProN-W6',
                                                # size: self.textLabel.font.pointSize)
                                                size: 16)
    end
    restyle!
  end
end