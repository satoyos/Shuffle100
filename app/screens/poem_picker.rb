class PoemPicker < PM::TableScreen
  include SelectedStatusHandler

  SELECTED_BG_COLOR = '#eebbcb'.to_color #撫子色
  title '歌を選ぶ'
  searchable placeholder: '歌を検索'

  attr_accessor :status100

  def on_load
    init_members
    # init_tool_bar
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
               accessory_type: status100.of_number(poem.number) ?
                   UITableViewCellAccessoryCheckmark :
                   UITableViewCellAccessoryNone,
               background_color: status100.of_number(poem.number) ?
                   SELECTED_BG_COLOR :
                   UIColor.whiteColor,
               action: :poem_tapped,
               arguments: {number: poem.number}
           }
         }
     }]
  end

  def poem_tapped(arg_hash)
    status100.reverse_in_number(arg_hash[:number])
    puts "searching? => #{searching?}" if BW::debug?
    # flip_poem_now(arg_hash[:number]) if searching?
    if searching?
      # flip_poem_now(arg_hash[:number])
      # @table_search_display_controller.searchResultsTableView.reloadData
      @table_search_display_controller.setActive(false, animated: true)
    else
    end
    update_table_and_prompt
  end

=begin
  def flip_poem_now(poem_number)
    cell = @table_search_display_controller.searchResultsDataSource.tableView(
        @table_search_display_controller.searchResultsTableView,
        cellForRowAtIndexPath: NSIndexPath.indexPathForRow(poem_number-1, inSection: 0))
    cell.backgroundColor = UIColor.blueColor
    puts "これから#{cell}を再描画します！"
    cell.setNeedsLayout
    cell
  end
=end
=begin
  def viewWillAppear(animated
    super

    puts 'reset search word in viewWillAppear' if BW::debug?
    if searching?
      @table_search_display_controller.searchBar.text = @table_search_display_controller.searchBar.text
    end
  end

  def will_appear
    init_tool_bar
    if searching?
      puts '+ reset search word in will_appear' if BW::debug?
      @table_search_display_controller.searchBar.text = @table_search_display_controller.searchBar.text
    else
      update_table_and_prompt
    end
  end
=end


  def will_disappear
    app_delegate.settings_manager.save
    # navigationController.setToolbarHidden(true, animated: true) if navigationController
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
    set_toolbar_items [{
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
                       }

                      ]
  end

  def select_all_poems
    status100.select_all
    update_table_and_prompt
  end

  def cancel_all_poems
    status100.cancel_all
    update_table_and_prompt
  end

  def select_by_ngram
    open NGramPicker.new
  end
end
