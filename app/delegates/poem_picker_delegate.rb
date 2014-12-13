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
    set_toolbar_items false
    FudaLayout.new.tap{ |l|
      l.view_size = self.class.fuda_layout_size
      l.view_origin = self.class.fuda_layout_origin
      l.shimo_str = poems[arg_hash[:number]-1].in_hiragana.shimo
      view.superview.addSubview(l.view) if view.superview
      l.get(:close_button).on(:touch){
        l.view.removeFromSuperview
        init_tool_bar
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