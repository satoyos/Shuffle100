module NGramPickerDataSource
  BC_FULL_IMG = 'blue_circle_full.png'.uiimage
  BC_HALF_IMG = 'blue_circle_half.png'.uiimage
  BC_NONE_IMG = 'blue_circle_empty.png'.uiimage

  FIRST_CHAR_PATTERN = '「%s」で始まる歌'

  class << self
    def cell_hashes_made_of(single_hash_array)
      cell_hashes = []
      single_hash_array.each do |single_hash|
        single_hash.each do |id_key, char_value|
          cell_hashes << {id: id_key, title: FIRST_CHAR_PATTERN % char_value}
        end
      end
      cell_hashes
    end
  end

  N_GRAM_SECTIONS = [
      {section_id: :one,
       header_title: '一枚札',
       items: [
           {id: :just_one, title: '一字決まりの歌'},
       ]
      },
      {section_id: :two,
       header_title: '二枚札',
       items: cell_hashes_made_of([
         {u:   'う'}, {tsu: 'つ'}, {shi: 'し'}, {mo:  'も'}, {yu:  'ゆ'}])
      },
      {section_id: :three,
       header_title: '三枚札',
       items: cell_hashes_made_of([
         {i:   'い'}, {chi: 'ち'}, {hi:  'ひ'}, {ki:  'き'}]),
      },
      {section_id: :four,
       header_title: '四枚札',
       items: cell_hashes_made_of([
         {ha: 'は'}, {ya: 'や'}, {yo: 'よ'}, {ka: 'か'}])
      },
      {section_id: :five,
       header_title: '五枚札',
       items: [
           {id: :mi,  title: FIRST_CHAR_PATTERN % 'み'},
       ]
      },
      {section_id: :six,
       header_title: '六枚札',
       items: cell_hashes_made_of([
           {ta: 'た'}, {ko: 'こ'}])
      },
      {section_id: :seven,
       header_title: '七枚札',
       items: cell_hashes_made_of([
           {o:  'お'}, {wa: 'わ'}])
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
      {section_id: :dummy, # 最後の『「あ」で始まる歌』までスクロールでき名問題を回避するため、余計なダミーを入れた。
                           # その問題を正しく解決できれば、このダミーは取り除きたい。
       header_title: ' ',
       items: []
      }
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