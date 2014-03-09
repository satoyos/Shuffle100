#class PoemPicker < UIViewController
class PoemPicker < PM::Screen
  include SelectedStatusHandler
  include PoemPickerDataSource
  include PoemPickerDelegate
  extend Forwardable

  def_delegators :@status100, :select_in_number, :[], :[]=

  TITLE = '歌を選ぶ'
  attr_accessor :status100

  def on_load
    self.status100 = loaded_selected_status

    setToolbarItems(toolbar_items, animated: true)

    init_table_view

    self.title = TITLE
    view.backgroundColor = UIColor.whiteColor
  end

  def will_appear
    self.status100 = loaded_selected_status
    navigationController.setToolbarHidden(false, animated: true) if navigationController
    table_view.reloadData
  end

  def will_disappear
    navigationController.setToolbarHidden(true, animated: true) if navigationController
  end

  def barButtonSystemItem(system_item)
    UIBarButtonItem.alloc.initWithBarButtonSystemItem(system_item,
                                                      target: nil,
                                                      action: nil)
  end

  def table_view
    @table_view ||= UITableView.alloc.initWithFrame(frame)
  end

  private

  def init_table_view
    table_view.dataSource = self
    table_view.delegate = self
    add table_view
  end

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

  def select_all_poems
    status100.select_all
    save_selected_status(status100)
    table_view.reloadData
  end

  def cancel_all_poems
    status100.cancel_all
    save_selected_status(status100)
    table_view.reloadData
  end

  def select_by_ngram
    navigationController.pushViewController(NGramPicker.alloc.init,
                                            animated: true)
  end

end
