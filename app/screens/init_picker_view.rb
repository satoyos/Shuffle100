module InitPickerView
  PICKER_VIEW_ACC_LABEL = 'picker_view'
  COMPONENT_ID = 0

  private

  def set_picker_view
    @picker_view = UIPickerView.alloc.init
    @picker_view.tap do |p_view|
      p_view.delegate = self
      p_view.dataSource = self
      p_view.frame = [
          [0, 0],
          [view.frame.size.width, picker_view.frame.size.height]
      ]
      p_view.showsSelectionIndicator = true
      p_view.selectRow(0, inComponent: COMPONENT_ID, animated: false)
      p_view.accessibilityLabel = PICKER_VIEW_ACC_LABEL
      view.addSubview(p_view)
    end
  end
end
