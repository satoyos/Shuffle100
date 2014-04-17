# class PoemPicker < PM::Screen
class PoemPicker < PM::TableScreen
  include SelectedStatusHandler
#  include PoemPickerDataSource
#  include PoemPickerDelegate
#  extend Forwardable

  SELECTED_BG_COLOR = '#eebbcb'.to_color #撫子色
  title '歌を選ぶ'

  # def_delegators :@status100, :select_in_number, :[], :[]=

  attr_accessor :status100

  def on_load
    self.status100 = loaded_selected_status
    # setToolbarItems(toolbar_items, animated: false)
    init_tool_bar
    update_table_and_prompt
  end

  def table_data
     [{
          cell_style: UITableViewCellStyleValue1,
          cells: poems.map{|poem|
            {
                # cell_class: PoemPickerTableCell,
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
     # self.navigationItem.prompt = '選択中: %d首' % status100.selected_num
     update_table_and_prompt
   end


=begin
    add table_view

    init_table_view

    view.backgroundColor = UIColor.whiteColor
=end
=begin
   def will_appear
#    self.status100 = loaded_selected_status
#     navigationController.setToolbarHidden(false, animated: false) if navigationController
# table_view.reloadData
   end
=end
  def will_appear
    init_tool_bar
    update_table_and_prompt
  end


  def will_disappear
    app_delegate.settings_manager.save
    # navigationController.setToolbarHidden(true, animated: true) if navigationController
    navigation_controller.setToolbarHidden(true, animated: false) if navigation_controller
  end

=begin
   def barButtonSystemItem(system_item)
     UIBarButtonItem.alloc.initWithBarButtonSystemItem(system_item,
                                                       target: nil,
                                                       action: nil)
   end
=end

  def poems
    @poems ||= Deck.original_deck.poems
  end


=begin
  def table_view
    @table_view ||= UITableView.alloc.initWithFrame(frame)
  end

  private

  def init_table_view
    table_view.dataSource = self
    table_view.delegate = self
  end
=end
#   private

  def update_table_and_prompt
    self.navigationItem.prompt = '選択中: %d首' % status100.selected_num
    update_table_data
  end

  def toolbar_items2

  end

=begin
   def toolbar_items
     [
         UIBarButtonItem.alloc.initWithTitle('全て取消',
                                             style: UIBarButtonItemStyleBordered,
                                             target: self,
                                             action: :cancel_all_poems),
         self.barButtonSystemItem(UIBarButtonSystemItemFlexibleSpace),
         UIBarButtonItem.alloc.initWithTitle('全て選択',
                                             style: UIBarButtonItemStyleBordered,
                                             target: self,
                                             action: :select_all_poems),
         self.barButtonSystemItem(UIBarButtonSystemItemFlexibleSpace),
         UIBarButtonItem.alloc.initWithTitle('1字目で選ぶ',
                                             style: UIBarButtonItemStyleBordered,
                                             target: self,
                                             action: :select_by_ngram)
     ]
   end
=end
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
    # save_selected_status(status100)
    # table_view.reloadData
  end

  def cancel_all_poems
    status100.cancel_all
    update_table_and_prompt
    # save_selected_status(status100)
    # table_view.reloadData
  end

  def select_by_ngram
    open NGramPicker.new
  end

end
