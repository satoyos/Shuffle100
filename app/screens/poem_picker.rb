class PoemPicker < PM::TableScreen
  include SelectedStatusHandler
  include PoemPickerDataSource
  include PoemPickerDelegate
  include OH::Notifications
  include PoemPickerSearchHelper

  title '歌を選ぶ'
  searchable placeholder: '歌を検索'
  longpressable

  attr_accessor :status100
  attr_reader :table_search_display_controller, :poems

  def on_load
    init_members
    set_font_changed_notification
    update_table_and_prompt
  end

  def init_members
    self.status100 = loaded_selected_status
    self
  end

  def will_appear
    init_tool_bar
    prepare_text_field
    update_table_and_prompt
  end

  def on_appear
    self.class.fuda_layout_frame ||= frame_for_fuda_layout
    double_tap_to_avoid_ios7_bug if BW2.ios_version_7?
  end

  def will_disappear
    app_delegate.settings_manager.save
    navigation_controller.setToolbarHidden(true, animated: false) if navigation_controller
  end

  def poems
    @poems ||= Deck.original_deck.poems
  end

  def font_changed(notification)
    update_table_and_prompt
  end

  class << self
    attr_accessor :fuda_layout_frame, :fuda_layout_frame_searching
  end

  private

  def double_tap_to_avoid_ios7_bug
    status100.reverse_in_number(1)
    update_table_and_prompt
    status100.reverse_in_number(1)
    update_table_and_prompt
  end

  def frame_for_fuda_layout
    origin = CGPointMake(topLayoutGuide.size.width, top_guide_height)
    size = CGSizeMake(frame.size.width,
                      frame.size.height + adjust_by_bottom_layout_guide + adjust_ios_version)
    CGRectMake(origin.x, origin.y, size.width, size.height)
  end

  def adjust_by_bottom_layout_guide
    bottomLayoutGuide.origin.y + bottomLayoutGuide.size.height
  end

  def adjust_ios_version
    case BW2.ios_version_7?
      when true
        puts 'iOS7.xですから！' if BW2.debug?
        -1 * topLayoutGuide.size.height
      else
        puts 'iOS8以降ですから！' if BW2.debug?
        0
    end
  end

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

  def alert_ngram_picker_disabled
    UIAlertView.alloc.init.tap{|alert_view|
      # alert_view.title ='歌を選びましょう'
      alert_view.message = '歌を検索している時には、このボタンは使えません。'
      alert_view.addButtonWithTitle('戻る')
    }.show
  end
end
