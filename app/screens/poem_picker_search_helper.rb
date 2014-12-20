module PoemPickerSearchHelper
  def refresh_search_result_table
    table_search_display_controller.searchBar.text = table_search_display_controller.searchBar.text
  end

  # @return [Array] 検索結果として表示されている歌全ての番号
  def search_result_poem_numbers
    @table_search_display_controller.searchResultsTableView.subviews[0].subviews.
        select{|sv| sv.is_a?(UITableViewCell) and not sv.hidden?}.
        map{|cell| cell.accessibilityLabel.to_i}.tap { |numbers|
      puts 'numbers in 検索結果 => ' if BW2.debug?
      ap numbers if BW2.debug?
    }
  end

  def prepare_text_field
    search_bar = view.subviews.find{|v| v.is_a?(UISearchBar)}
    search_bar.subviews[0].subviews[1].tap do |text_field|
      text_field.accessibilityLabel = 'search_text_field'
      set_text_field_japanese(text_field)
    end
  end

  # @param [UITextField] text_field
  def set_text_field_japanese(text_field)
    text_field.keyboardType = UIKeyboardTypeDefault
  end

  def frame_for_fuda_layout_searching
    puts_info_about_layout_guide if BW2.debug?
    origin = CGPointMake(topLayoutGuide.size.width, top_guide_height)
    size = CGSizeMake(frame.size.width,
                      frame.size.height +
                          adjust_by_bottom_layout_guide +
                          adjust_ios_version_searching)
    CGRectMake(origin.x, origin.y, size.width, size.height)
  end

  def adjust_ios_version_searching
    case BW2.ios_version_7?
      when true
        puts 'iOS7.xですから！' if BW2.debug?
        -1 * topLayoutGuide.size.height
      else
        puts 'iOS8以降ですから！' if BW2.debug?
        -1 * bottomLayoutGuide.origin.y
    end
  end
end