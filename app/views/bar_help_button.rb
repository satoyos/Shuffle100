class BarHelpButton < NavBarButton
  class << self

    private

    def button_image(size)
      @help_image ||= {}
      @help_image[size] ||= header_button_from_image_file('question_white.png', size: size)
    end
  end
end