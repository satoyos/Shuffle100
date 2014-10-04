class BarExitButton < NavBarButton
  class << self

    private

    def button_image(size)
      @exit_image ||= {}
      @exit_image[size] ||= header_button_from_image_file('exit_square_org.png', size: size)
    end
  end
end