class NavBarButton < UIButton
  # constructor
  def self.create_with_square_size(size)
    self.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      button_size = button_size_calc_by_env(size)
      b.frame = CGRectMake(0, 0, button_size, button_size)
      b.set_image_after_frame_is_set
    end
  end

  def set_image_after_frame_is_set
    raise 'Frame must be set before calling this method.' unless
        frame.size and frame.size.height > 0
    setImage(self.class.button_image(frame.size.height), forState: UIControlStateNormal)
  end

  private

  def self.header_button_from_image_file(file_path, size: size)
    ResizeUIImage.resizeImage(UIImage.imageNamed(file_path),
                              newSize: CGSizeMake(size, size)).tap {|img|
      puts "作成されたNavBar用Imageのサイズ => [#{img.size.width}, #{img.size.height}]" if BW2.debug?
      puts " -- retina_ratio => #{BW2.retina_ratio}" if BW2.debug?
    }.imageWithRenderingMode(UIImageRenderingModeAlwaysTemplate)
  end

  def self.button_size_calc_by_env(size)
    button_size = size
    if BW2.retina_ratio > 2.1
      button_size *= 2.0/3
      puts "3xのRetinaスクリーンなので、サイズを2/3にして作ります。" if BW2.debug?
    end
    button_size
  end

end