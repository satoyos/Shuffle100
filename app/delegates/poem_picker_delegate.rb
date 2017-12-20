module PoemPickerDelegate

  def poem_tapped(poem)
    puts "△ 歌番号#{poem.number}番の選択状態を反転します。" if BW2.debug?
    status100.reverse_in_number(poem.number)
    update_table_and_prompt
    puts "searching? => #{searching?}" if BW2.debug?
    if searching?
      puts 'reset search word in poem tapped!' if BW2.debug?
      refresh_search_result_table
    end
  end

  def poem_long_pressed(poem)
    puts "▲ 歌番号#{poem.number}番の取り札を表示します。" if BW2.debug?
    open_modal FudaScreen.new(nav_bar: true).tap{|s|
                 s.fuda_str = poem.in_hiragana.shimo
                 puts "→表示する下の句: #{s.fuda_str}" if BW2.debug?
                 s.nav_bar_title = poem.str_with_number_and_liner
               }
  end

  def select_all_poems
    if searching?
      status100.select_in_numbers(filtered_poem_numbers)
      update_table_and_prompt
      refresh_search_result_table
    else
      status100.select_all
      update_table_and_prompt
    end
  end

  def cancel_all_poems
    if searching?
      status100.cancel_in_numbers(filtered_poem_numbers)
      update_table_and_prompt
      refresh_search_result_table
    else
      status100.cancel_all
      update_table_and_prompt
    end
  end

  def select_by_five_colors
    puts "You select 五色から選ぶ！" if BW2.debug?
    open FiveColorsScreen.new
  end

  def select_by_ngram
    if searching?
      alert_ngram_picker_disabled
      return
    end
    open NGramPicker.new
  end
end