class PoemPicker < PM::TableScreen
  include SelectedStatusHandler
  include PoemPickerDataSource
  include PoemPickerDelegate
  include OH::Notifications
  include PoemPickerSearchHelper

  title '歌を選ぶ'
  searchable placeholder: '歌を検索'
  longpressable

  def on_load
    self.navigationItem.prompt = AppDelegate::PROMPT
    init_selected_status_and_badge
    set_font_changed_notification
    update_table_and_prompt
  end

  def on_appear
    init_tool_bar
  end

  def will_appear
    update_badge_value
    update_table_and_prompt
  end

  def on_present
    prepare_text_field
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

  private

  def update_table_and_prompt
    update_badge_value
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
=begin
                 # Ver.5 以降
                 title: 'まとめて選ぶ',
                 action: :select_by_group
=end
                 # Ver.4.xxまで
                 title: '1字目で選ぶ',
                 action: :select_by_ngram
             }]
    set_toolbar_items items
  end

  def alert_ngram_picker_disabled
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.message = '歌を検索している時には、このボタンは使えません。'
      alert_view.addButtonWithTitle('戻る')
    }.show
  end

  # Ver.5以降で札セットをサポート
  def create_button_and_badge_icon
    @badge_button = PoemsNumberSelectedItem.create_with_origin_x(-50, '保存', self, 'save_button_tapped:')
  end

end
