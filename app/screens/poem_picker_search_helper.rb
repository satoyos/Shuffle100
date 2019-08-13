module PoemPickerSearchHelper
  def refresh_search_result_table
    # @table_search_display_controller.searchBar.text = @table_search_display_controller.searchBar.text
  end

  def filtered_poem_numbers
    promotion_table_data.filtered_data[0][:cells].map { |cell_hash|
      cell_hash[:arguments].number
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
end