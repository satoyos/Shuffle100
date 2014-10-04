# class BarGearButton
class BarGearButton < NavBarButton

  class << self

    private

    def button_image(size)
      @gear_image ||= {}
      @gear_image[size] ||= header_button_from_image_file('gear-520.png', size: size)
    end
  end
end