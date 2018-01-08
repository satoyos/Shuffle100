class NGramPicker < PM::Screen
  include SelectedStatusHandler
  include NGramPickerDataSource
  include NGramPickerDelegate

  title '1字目で選ぶ'

  attr_reader :table_view

  def on_load
    view.backgroundColor = UIColor.whiteColor
    self.navigationItem.prompt = AppDelegate::PROMPT
    init_selected_status_and_badge
    init_table_view
    add table_view
  end

  def init_table_view
    @table_view =
        UITableView.alloc.initWithFrame(frame,
                                        style: UITableViewStyleGrouped).tap do |t_view|
          t_view.dataSource = self
          t_view.delegate = self
        end
  end

  def on_appear
    reload_table_data_and_prepare
  end

  private

  def reload_table_data_and_prepare(content_offset=nil)
    table_view.reloadData
    enlarge_content_size(100) # この拡張値は、見栄えがよい適当な数字。
    set_content_offset(content_offset) if content_offset
    # ↑ tableViewのcontentSizeをムリに拡張している（いつかこのムリは直したい）分、再描画時のオフセットがズレる。
    #   そのズレを無くすため、描画前のオフセットを維持するようにしている。
  end

  def enlarge_content_size(plus_to_height)
    table_view.contentSize =
        CGSizeMake(table_view.contentSize.width,
                   table_view.contentSize.height + plus_to_height)
  end

  def set_content_offset(content_offset)
    table_view.setContentOffset(CGSizeMake(0, content_offset))
  end

end