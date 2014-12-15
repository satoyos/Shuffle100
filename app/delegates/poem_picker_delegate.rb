module PoemPickerDelegate

  def poem_tapped(arg_hash)
    status100.reverse_in_number(arg_hash[:number])
    update_table_and_prompt
    puts "searching? => #{searching?}" if BW2.debug?
    if searching?
      puts 'reset search word in poem tapped!' if BW2.debug?
      refresh_search_result_table
    end
  end

  def poem_long_pressed(arg_hash)
    if BW2.ios_version_7?
      table_offset = tableView.contentOffset
      puts 'table_offset => ' if BW2.debug?
      ap table_offset if BW2.debug?
    end
    set_toolbar_items false
    FudaLayout.new.tap{ |l|
      l.view_size = self.class.fuda_layout_size
      l.view_origin = self.class.fuda_layout_origin
      l.shimo_str = poems[arg_hash[:number]-1].in_hiragana.shimo
      l.view.alpha = 0
      view.superview.addSubview(l.view) if view.superview
      l.view.fade_in(duration: 0.1)
      l.get(:close_button).on(:touch){
        init_tool_bar
        self.tableView.setContentOffset(table_offset, animated: false) if BW2.ios_version_7?
        l.view.fade_out do
          l.view.removeFromSuperview
          double_tap_to_avoid_ios7_bug if BW2.ios_version_7?
        end
      }
    }
  end

  private

  def select_all_poems
    if searching?
      status100.select_in_numbers(search_result_poem_numbers)
      update_table_and_prompt
      refresh_search_result_table
    else
      status100.select_all
      update_table_and_prompt
    end
  end

  def cancel_all_poems
    if searching?
      status100.cancel_in_numbers(search_result_poem_numbers)
      update_table_and_prompt
      refresh_search_result_table
    else
      status100.cancel_all
      update_table_and_prompt
    end
  end

  def select_by_ngram
    if searching?
      alert_ngram_picker_disabled
      return
    end
    open NGramPicker.new
  end
end