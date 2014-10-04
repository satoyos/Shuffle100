class NavBarButton
  class << self
    def create_with_square_size(size)
      UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
        b.frame = CGRectMake(0, 0, size, size)
        b.setImage(button_image(size), forState: UIControlStateNormal)
      end
    end

    private

    def header_button_from_image_file(file_path, size: size)
      ResizeUIImage.resizeImage(UIImage.imageNamed(file_path),
                                newSize: CGSizeMake(size, size)).tap {|img|
        puts "作成されたNavBar用Imageのサイズ => [#{img.size.width}, #{img.size.height}]" if BW2.debug?
        BW2.retina_ratio = img.size.width / size
        puts " -- retina_ratio => #{BW2.retina_ratio}"
      }.imageWithRenderingMode(UIImageRenderingModeAlwaysTemplate)
    end
  end
end