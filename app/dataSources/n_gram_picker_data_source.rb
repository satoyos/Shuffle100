module NGramPickerDataSource
#  include NGramSections

  BC_FULL_IMG = UIImage.imageNamed('blue_circle_full.png')
  BC_HALF_IMG = UIImage.imageNamed('blue_circle_half.png')
  BC_NONE_IMG = UIImage.imageNamed('blue_circle_empty.png')

  FIRST_CHAR_PATTERN = '「%s」で始まる歌'
  N_GRAM_SECTIONS = [
      {section_id: :one,
       header_title: '一枚札',
       items: [
           {id: :just_one, title: '一字決まりの歌'},
       ]
      },
      {section_id: :two,
       header_title: '二枚札',
       items: [
           {id: :u,   title: FIRST_CHAR_PATTERN % 'う'},
           {id: :tsu, title: FIRST_CHAR_PATTERN % 'つ'},
           {id: :shi, title: FIRST_CHAR_PATTERN % 'し'},
           {id: :mo,  title: FIRST_CHAR_PATTERN % 'も'},
           {id: :yu,  title: FIRST_CHAR_PATTERN % 'ゆ'},
       ]
      },
      {section_id: :three,
       header_title: '三枚札',
       items: [
           {id: :i,   title: FIRST_CHAR_PATTERN % 'い'},
           {id: :chi, title: FIRST_CHAR_PATTERN % 'ち'},
           {id: :hi,  title: FIRST_CHAR_PATTERN % 'ひ'},
           {id: :ki,  title: FIRST_CHAR_PATTERN % 'き'},
       ]
      },
      {section_id: :four,
       header_title: '四枚札',
       items: [
           {id: :ha,  title: FIRST_CHAR_PATTERN % 'は'},
           {id: :ya,  title: FIRST_CHAR_PATTERN % 'や'},
           {id: :yo,  title: FIRST_CHAR_PATTERN % 'よ'},
           {id: :ka,  title: FIRST_CHAR_PATTERN % 'か'},
       ]
      },
      {section_id: :five,
       header_title: '五枚札',
       items: [
           {id: :mi,  title: FIRST_CHAR_PATTERN % 'み'},
       ]
      },
      {section_id: :six,
       header_title: '六枚札',
       items: [
           {id: :ta,  title: FIRST_CHAR_PATTERN % 'た'},
           {id: :ko,  title: FIRST_CHAR_PATTERN % 'こ'},
       ]
      },
      {section_id: :seven,
       header_title: '七枚札',
       items: [
           {id: :o,   title: FIRST_CHAR_PATTERN % 'お'},
           {id: :wa,  title: FIRST_CHAR_PATTERN % 'わ'},
       ]
      },
      {section_id: :eight,
       header_title: '八枚札',
       items: [
           {id: :na,  title: FIRST_CHAR_PATTERN % 'な'},
       ]
      },
      {section_id: :sixteen,
       header_title: '十六枚札',
       items: [
           {id: :a,   title: FIRST_CHAR_PATTERN % 'あ'},
       ]
      },
  ]

  def numberOfSectionsInTableView(tableView)
    N_GRAM_SECTIONS.size
  end

  def tableView(tableView, titleForHeaderInSection: section)
    N_GRAM_SECTIONS[section][:header_title]
  end

  def tableView(tableView, numberOfRowsInSection:section)
    N_GRAM_SECTIONS[section][:items].size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    # 一応慣例に従ってreuseIdentifierは作成するが、
    # この画面を作る負荷は小さいので、問題が出ない限り使わない。
    @reuseIdentifier ||= 'CELL_IDENTIFIER'

    UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault,
                                        reuseIdentifier: @reuseIdentifier).tap do |cell|
      cell.textLabel.text = text_of(indexPath)
      cell.accessibilityLabel = "#{id_of(indexPath)}"
      cell.imageView.image =
          ui_image_for_status(selected_status_of_char(id_of(indexPath)),
                              of_height: height_of(cell))
    end
  end

  private

  def ui_image_for_status(status_symbol, of_height: height)
    image = case status_symbol
              when :full    ; BC_FULL_IMG
              when :partial ; BC_HALF_IMG
              when :none    ; BC_NONE_IMG
              else ; raise "Invalid status #{status_symbol}"
            end
    ResizeUIImage.resizeImage(image,
                              newSize: CGSizeMake(height, height))
  end

  # @param [UIView] view
  def height_of(view)
    view.frame.size.height
  end

  def item_hash(indexPath)
    N_GRAM_SECTIONS[indexPath.section][:items][indexPath.row]
  end

  def text_of(indexPath)
    item_hash(indexPath)[:title]
  end

  def id_of(indexPath)
    item_hash(indexPath)[:id]
  end
end