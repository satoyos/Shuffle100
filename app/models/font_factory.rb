
module FontFactory
  FONT_TYPE_HASH = {
      japanese:   'HiraMinProN-W3',
      japaneseW6: 'HiraMinProN-W6'
  }

  module_function

  def self.create_font_with_type(font_type, size: size)
    if FONT_TYPE_HASH[font_type] then
      UIFont.fontWithName(FONT_TYPE_HASH[font_type], size: size)
    else
      UIFont.systemFontOfSize(size)
    end
  end

end