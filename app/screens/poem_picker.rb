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
    search_setup
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
    # prepare_text_field
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

  def on_return(args={})
    if args[:mode] == :fix_new_name
      app_delegate.game_settings.fuda_sets <<
          FudaSet.new(args[:name], status100.clone)
      app_delegate.settings_manager.save
      show_dialog_fuda_set_saved(args[:name])
    elsif args[:mode] == :fix_overwritten
      puts "[#{args[:index]}]番の札セットを書き換えます" if BW2.debug?
      org_set_name = app_delegate.game_settings.fuda_sets[args[:index]].name
      app_delegate.game_settings.fuda_sets[args[:index]] = FudaSet.new(org_set_name, status100.clone)
      app_delegate.settings_manager.save
      show_dialog_fuda_set_overwritten(org_set_name)
    else
      @status100 = loaded_selected_status
      update_badge_value
      update_table_and_prompt
    end
  end

  def should_autorotate
    false
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
                 # Ver.5 以降
                 title: 'まとめて選ぶ',
                 action: :select_by_group
             }]
    set_toolbar_items items
  end

  def alert_ngram_picker_disabled
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.message = '歌を検索している時には、このボタンは使えません。'
      alert_view.addButtonWithTitle('戻る')
    }.show
  end

  def show_dialog_fuda_set_saved(new_set_name)
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.title ='保存完了'
      alert_view.message = "新しい札セット「#{new_set_name}」を保存しました。"
      alert_view.addButtonWithTitle('OK')
    }.show
  end

  def show_dialog_fuda_set_overwritten(set_name)
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.title ='上書き保存完了'
      alert_view.message = "札セット「#{set_name}」を上書きしました。"
      alert_view.addButtonWithTitle('OK')
    }.show
  end

  # Ver.5以降で札セットをサポート
  def create_button_and_badge_icon
    @badge_button = PoemsNumberSelectedItem.create_with_origin_x(-50, '保存', self, 'save_button_tapped:')
  end

  # iOS13以降で検索の仕組みが変わったことに対応
  def search_setup
    @search_controller.tap do |sc|
      sc.searchResultsUpdater = self
      sc.hidesNavigationBarDuringPresentation = false
      sc.obscuresBackgroundDuringPresentation = false
      sc.searchBar.placeholder = "歌を検索"
    end
  end

end
