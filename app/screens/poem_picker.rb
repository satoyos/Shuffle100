class PoemPicker < PM::TableScreen
  include SelectedStatusHandler

  SELECTED_BG_COLOR = '#eebbcb'.to_color #撫子色
  title '歌を選ぶ'
  searchable placeholder: '歌を検索'

  attr_accessor :status100

  def on_load
    init_members
    update_table_and_prompt
  end

  def init_members
    self.status100 = loaded_selected_status
    self
  end

  def table_data
    [{
         cell_style: UITableViewCellStyleValue1,
         cells: poems.map{|poem|
           {
               title: '%3d. %s %s %s' %
                   [poem.number, poem.liner[0], poem.liner[1], poem.liner[2]],

               font: UIFont.fontWithName('HiraMinProN-W6', size: 16),
               subtitle: "　　 #{poem.poet}",
               accessibility_label: '%03d' % poem.number,
               accessory_type: acc_type_for_poem(poem),
               background_color: bg_color_for_poem(poem),
               search_text: search_text_for_poem(poem),
               action: :poem_tapped,
               arguments: {number: poem.number}
           }
         }
     }]
  end

  def poem_tapped(arg_hash)
    status100.reverse_in_number(arg_hash[:number])
    update_table_and_prompt
    puts "searching? => #{searching?}" if BW::debug?
    if searching?
      puts 'reset search word in poem tapped!' if BW::debug?
      refresh_search_result_table
    end
  end

  def will_appear
    init_tool_bar
    puts "main_view => [#{view}]" if BW::debug?
    prepare_text_field
    update_table_and_prompt
  end


  def will_disappear
    app_delegate.settings_manager.save
    navigation_controller.setToolbarHidden(true, animated: false) if navigation_controller
  end

  def poems
    @poems ||= Deck.original_deck.poems
  end


  private

  def update_table_and_prompt
    self.navigationItem.prompt = '選択中: %d首' % status100.selected_num
    update_table_data
  end

  def init_tool_bar
    return unless navigation_controller
    items = [{
                 title: '全て取消',
                 action: :cancel_all_poems
             }, {
                 system_item: :flexible_space
             }, {
                 title: '全て選択',
                 action: :select_all_poems
             }, {
                 system_item: :flexible_space
             }, {
                 title: '1字目で選ぶ',
                 action: :select_by_ngram
             }]
    set_toolbar_items items
  end

  def refresh_search_result_table
    @table_search_display_controller.searchBar.text = @table_search_display_controller.searchBar.text
  end

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

  # @return [Array] 検索結果として表示されている歌全ての番号
  def search_result_poem_numbers
    @table_search_display_controller.searchResultsTableView.subviews[0].subviews.
        select{|sv| sv.is_a?(UITableViewCell) and not sv.hidden?}.
        map{|cell| cell.accessibilityLabel.to_i}.tap { |numbers|
      puts 'numbers in 検索結果 => ' if BW::debug?
      ap numbers if BW::debug?
    }
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

  # @param [Poem] poem
  # @return [UIColor]
  def bg_color_for_poem(poem)
    status100.of_number(poem.number) ?
        SELECTED_BG_COLOR :
        UIColor.whiteColor
  end

  # @param [Poem] poem
  # @return [UITableViewCellEditingStyle]
  def acc_type_for_poem(poem)
    status100.of_number(poem.number) ?
        UITableViewCellAccessoryCheckmark :
        UITableViewCellAccessoryNone
  end

  # @param [Poem] poem
  # @return [String]
  def search_text_for_poem(poem)
    [poem.liner, poem.in_hiragana, poem.in_modern_kana, poem.poet, poem.kimari_ji].
        flatten.join(' ')
  end

  def alert_ngram_picker_disabled
    UIAlertView.alloc.init.tap{|alert_view|
      # alert_view.title ='歌を選びましょう'
      alert_view.message = '歌を検索している時には、このボタンは使えません。'
      alert_view.addButtonWithTitle('戻る')
    }.show
  end

end
