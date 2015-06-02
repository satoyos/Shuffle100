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
  attr_reader :badge_button

  def on_load
    init_members
    set_font_changed_notification
    set_badge_button
    budge_button_size_plus(2)
    update_table_and_prompt
  end

  def init_members
    self.status100 = loaded_selected_status
    @badge_button = BBBadgeBarButtonItem.alloc.initWithCustomUIButton(UIButton.alloc.init).tap do |bb|
      bb.badgeOriginX = -50.0
      bb.shouldHideBadgeAtZero = false
    end
    self
  end

  def on_appear
    init_tool_bar
  end

  def will_appear
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
    self.navigationItem.prompt = AppDelegate::PROMPT
    badge_button.badgeValue = "#{status100.selected_num}首"
    update_table_data
  end

  def budge_button_size_plus(plus_size)
    org_font_size = badge_font.pointSize
    badge_button.badgeFont = badge_font.fontWithSize(org_font_size + plus_size)
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

  def set_badge_button
    set_nav_bar_button :right, {
                                 button: badge_button
                             }
  end

  def badge_font
    badge_button.badgeFont
  end
end
