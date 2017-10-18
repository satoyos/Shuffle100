class NavBarButton < UIButton
  def set_image_after_frame_is_set
    raise 'Frame must be set before calling this method.' unless
        frame.size and frame.size.height > 0
    setImage(self.class.button_image(frame.size.height), forState: UIControlStateNormal)
  end

  class << self
    def create_with_square_size(size)
      button_size = button_size_by_ios_version(size)
      self.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
        b.frame = CGRectMake(0, 0, button_size, button_size)
        b.set_image_after_frame_is_set
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

    def self.button_size_by_ios_version(size)
      button_size = size
      if BW2.ios_major_ver_num < 11
        button_size *= 2
        puts "iOSのバージョンが#{BW2.ios_version}なので、ボタン用の画像を倍サイズで作ります。" if BW2.debug?
      end
      button_size
    end
  end
end