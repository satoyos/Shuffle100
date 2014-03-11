module NGramPickerDataSource
  include NGramSections

  BC_FULL_IMG = UIImage.imageNamed('blue_circle_full.png')
  BC_HALF_IMG = UIImage.imageNamed('blue_circle_half.png')
  BC_NONE_IMG = UIImage.imageNamed('blue_circle_empty.png')

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