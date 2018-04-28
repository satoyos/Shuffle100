class PoemsNumberSelectedItem < BBBadgeBarButtonItem

  class << self
    def create_with_origin_x(org_x, title=nil)
      self.alloc.initWithCustomUIButton(create_base_button(title)).tap do |bb|
        bb.badgeOriginX = org_x
        bb.badgeOriginY = 0.0  if BW2.ios_major_ver_num >= 11
        bb.shouldHideBadgeAtZero = false
      end
    end

    #ToDo: PagePicker上で、このボタンに対するアクションを設定できるはず！

    def create_base_button(title)
      set_title = title ? title : ''
      UIButton.alloc.init.tap do |b|
        b.setTitle(set_title, forState: UIControlStateNormal)
        b.setTitleColor('blue'.uicolor, forState: UIControlStateNormal)
      end
    end
  end

  def button_size_plus(plus_size)
    org_font_size = badge_font.pointSize
    self.badgeFont = badge_font.fontWithSize(org_font_size + plus_size)
  end

  def badge_font
    self.badgeFont
  end
end