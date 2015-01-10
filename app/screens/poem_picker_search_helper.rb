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

  ####################
  # KVO
  def set_kvo_searching
    promotion_table_data.addObserver(self,
                     forKeyPath: 'filtered',
                     options: NSKeyValueObservingOptionNew,
                     context: nil)
  end

  def will_dismiss
    promotion_table_data.removeObserver(self, forKeyPath: 'filtered')
  end

  def observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
    puts "something changed! (#{keyPath})" if BW2.debug?
    if keyPath == 'filtered'
      puts "★KVOが filteredの値の変化を検出しました。(現在: #{promotion_table_data.filtered})" if BW2.debug?
      Dispatch::Queue.concurrent.async{
        NSThread.sleepForTimeInterval 0.1
        Dispatch::Queue.main.async{
          @searching_offset_y = table_search_display_controller.searchResultsTableView.contentOffset.y
          puts "@searching_offset_y = #{@searching_offset_y}" if BW2.debug?
        }
      }
    end
  end

end