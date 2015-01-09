=begin
module ProMotion
  module Table
    module Longpressable

      def make_longpressable(params={})
        params = {
            min_duration: 1.0
        }.merge(params)

        long_press_gesture = UILongPressGestureRecognizer.alloc.initWithTarget(self, action:"on_long_press:")
        long_press_gesture.minimumPressDuration = params[:min_duration]
        long_press_gesture.delegate = self
        self.table_view.addGestureRecognizer(long_press_gesture)
      end

      def on_long_press(gesture)
        return unless gesture.state == UIGestureRecognizerStateBegan
        gesture_point = gesture.locationInView(table_view)
        puts '!! gesture_point => '
        ap gesture_point
        index_path = table_view.indexPathForRowAtPoint(gesture_point)
        puts '!! index_path => '
        ap index_path
        data_cell = self.promotion_table_data.cell(index_path: index_path)
        trigger_action(data_cell[:long_press_action], data_cell[:arguments], index_path) if data_cell[:long_press_action]
      end
    end
  end
end
=end


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

  def on_appear
    init_tool_bar
  end

  def on_presant
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

  def font_changed(notification)
    update_table_and_prompt
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

  def alert_ngram_picker_disabled
    UIAlertView.alloc.init.tap{|alert_view|
      # alert_view.title ='歌を選びましょう'
      alert_view.message = '歌を検索している時には、このボタンは使えません。'
      alert_view.addButtonWithTitle('戻る')
    }.show
  end
end
