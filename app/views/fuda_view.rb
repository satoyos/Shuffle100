class FudaView < UIImageView
  # 札のサイズに関する定数の設定
  # INITIAL_FONT_HEIGHT   =
  INITIAL_FUDA_FONT = UIFont.fontWithName('HiraMinProN-W3',size: 30)
  FUDA_SIZE_IN_MM = CGSizeMake(53.0, 73.0)  # 札ビューはこの縦横比になる。

  FONT_SIZE_DIVIDED_BY_POWER = 11 # これに@fuda_powerをかけたものが@font_sizeの値となる。
  OFFSET_DIVIDED_BY_POWER = 2     # これに@fuda_powerをかけたものが@green_offsetの値となる。

  # サイズ以外の定数の設定
  INSIDE_COLOR = 0xFFF7E5.uicolor
  WASHI_JPG_FILE  = 'washi_darkgreen 001.jpg'
  STRING_NOT_SET_MESSAGE = '札の文字はまだ決まっていません'
  ACCESSIBILITY_LABEL = 'fuda_view'
  ACC_LABEL_OF_INSIDE_VIEW = 'inside_view'
  STR_FOR_FUDA_LABEL_ACC = 'FudaChar%02d'

  attr_reader :labels15

  # 札Viewのサイズ(frame.size)を決め、上に載るオブジェクトを積み上げる。
  # 札Viewの位置(frame.origin)にはCGPointZeroを設定する
  def initWithString(string)
    set_accessibility_label()
    create_green_frame_on_me()
    create_background_view_on_me()
    create_labels_on_me(string)
    self
  end

  # 札Viewのframe.sizeを決めてしまう。
  # また、札Viewに乗っているSubviewsのサイズもこのタイミングで決めてしまう。
  def set_all_sizes_by(fuda_height)
    set_fuda_size_by(fuda_height)
    set_size_of_subviews()
  end

  def rewrite_string(string)
    chars = string.split(//u)
    @labels15.each_with_index do |label, idx|
      label.text= chars[idx] || ''
    end
  end

  # 以下、プライベートな定義
  private

  def set_accessibility_label
    self.accessibilityLabel= ACCESSIBILITY_LABEL
  end

  def set_fuda_size_by(fuda_height)
    @height = fuda_height
    @fuda_power = fuda_height / FUDA_SIZE_IN_MM.height
    self.frame = [CGPointZero, [fuda_width, fuda_height]]
  end

  def fuda_width
    FUDA_SIZE_IN_MM.width * @fuda_power
  end

  # 緑和紙の「額縁」を生成して載せる。
  def create_green_frame_on_me
    self.initWithImage(UIImage.imageNamed(WASHI_JPG_FILE))
  end

  # 札の白台紙ビューを生成して載せる。
  # (ただし、frameにはCGRectZeroを設定し、frame以外の属性は設定しておく)
  def create_background_view_on_me
    @fuda_inside_view = UIView.alloc.initWithFrame(CGRectZero)
    @fuda_inside_view.tap do |i_view|
      i_view.backgroundColor= INSIDE_COLOR
      i_view.accessibilityLabel= ACC_LABEL_OF_INSIDE_VIEW
      self.addSubview(i_view)
    end
  end

  # stringの1文字ずつを割り当てた15枚のラベルを生成して載せる。
  # (ラベルについても、サイズの情報は一切設定しない。)
  def create_labels_on_me(string)
    @labels15 = []
    torifuda_str_array = string.split(//u)
    (0..14).each do |idx|
      label = UILabel.alloc.initWithFrame(CGRectZero)
      label.tap do |l|
        l.text= torifuda_str_array[idx] || ''
        l.font= INITIAL_FUDA_FONT
        l.textAlignment= UITextAlignmentCenter
        l.backgroundColor= UIColor.clearColor
        l.accessibilityLabel= STR_FOR_FUDA_LABEL_ACC % idx
        self.addSubview(l)
        @labels15 << l
      end
    end
  end

  # 札View自体のサイズが決定した結果を受けて、札Viewの子Viewのサイズも決める。
  def set_size_of_subviews
    calc_font_size()
    calc_green_offset()
    set_fuda_inside_view_size()
    set_label_frame_and_font()
  end

  def calc_font_size
    @font_size = @fuda_power * FONT_SIZE_DIVIDED_BY_POWER
  end

  def calc_green_offset
    @green_offset = @fuda_power * OFFSET_DIVIDED_BY_POWER
  end

  # 札の白い和紙部分のViewについて、サイズを決定。
  def set_fuda_inside_view_size
    @fuda_inside_view.frame = CGRectMake(@green_offset,
                                         @green_offset,
                                         fuda_size.width  - @green_offset * 2,
                                         fuda_size.height - @green_offset * 2)
  end

  def fuda_size
    self.frame.size
  end
  
  def set_label_frame_and_font
    new_font = @labels15.first.font.fontWithSize(@font_size)
    @labels15.each_with_index do |label, label_number|
      label.frame = [label_origin_of(label_number), label_size]
      label.font  = new_font
    end
  end

  def label_origin_of(label_number)
    CGPointMake(
        label_origin_zero.x + label_size.width * column_number_of(label_number),
        label_origin_zero.y + label_size.height * (label_number % 5))
  end

  def column_number_of(label_number)
    case label_number
      when (0..4); 2
      when (5..9); 1
      else       ; 0
    end
  end

  def label_size
    CGSizeMake((fuda_size.width - @green_offset * 2) / 3,
               (fuda_size.height - @green_offset * 2) / 5)
  end
  
  def label_origin_zero
=begin
    CGPoint.new(@green_offset, @green_offset + @font_size * 2 / 10)
    #                              この補正は…^^^^^^^^^^^^^^^^^^^^^
    # 和風フォントで上下方向のセンタリングがうまく機能しないため、仕方なく行っている。
=end
    # 上記のバグはXcode5 SDKで修正されたようなので、補正は外す。
    CGPoint.new(@green_offset, @green_offset)
  end

end
