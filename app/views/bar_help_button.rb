class BarHelpButton < NavBarButton
  ACC_LABEL = 'help'

  class << self

    def create_with_square_size(size)
      super.tap {|b|
        b.accessibilityLabel = ACC_LABEL
      }
    end

    def button_image(size)
      @help_image ||= {}
      @help_image[size] ||= header_button_from_image_file('question_white.png', size: size)
    end
  end
end