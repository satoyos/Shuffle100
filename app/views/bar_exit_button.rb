class BarExitButton < NavBarButton
  ACC_LABEL = 'exit'

  class << self
    def create_with_square_size(size)
      super.tap {|b|
        b.accessibilityLabel = ACC_LABEL
      }
    end

    private

    def button_image(size)
      @exit_image ||= {}
      @exit_image[size] ||= header_button_from_image_file('exit_square_org.png', size: size)
    end
  end
end