class WhatsNextButton < UIButton
  include NormalButtonStyles

  def init_title_style_and_image(image_name)
    imageView.contentMode = UIViewContentModeScaleAspectFit
    setImage(resized_image_of_name(image_name, square_size: self.height),
             forState: UIControlStateNormal)
    setTitleColor(:blue.uicolor, forState: UIControlStateNormal)
    set_button_title_color
    self
  end

  private

  def resized_image_of_name(img_file_name, square_size: height)
    self.class.resized_image_of_name(img_file_name, square_size: height)
  end

  class << self
    def  resized_image_of_name(img_file_name, square_size: height)
      @image_hash = {} unless @image_hash
      return @image_hash[img_file_name] if @image_hash[img_file_name]
      puts "[#{img_file_name}]から画像を読み込んで、UIImageを作ります。" if BW2.debug?
      @image_hash[img_file_name] =
          ResizeUIImage.resizeImage(img_file_name.uiimage,
                                    newSize: CGSizeMake(height, height)).tap{|img|
            puts "作成されたUIImageのサイズ => [#{img.size.width}, #{img.size.height}]" if BW2.debug?
            puts " -- retina_ratio => #{BW2.retina_ratio}" if BW2.debug?
          }
    end
  end
end