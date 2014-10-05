class BarGearButton < NavBarButton
  ACC_LABEL = 'gear'

  class << self
    def create_with_square_size(size)
      super.tap {|b|
        b.accessibilityLabel = ACC_LABEL
      }
    end

    def button_image(size)
      @gear_image ||= {}
      @gear_image[size] ||= header_button_from_image_file('gear-520.png', size: size)
    end
  end
end