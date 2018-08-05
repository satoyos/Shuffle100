module InitPickerView
  PICKER_VIEW_ACC_LABEL = 'picker_view'
  COMPONENT_ID = 0

  private

  def set_picker_view(use_y_offset_flg=false)
    @picker_view = UIPickerView.alloc.init
    @picker_view.tap do |p_view|
      p_view.delegate = self
      p_view.dataSource = self
      org_y = use_y_offset_flg ? offset_origin_y : 0
      p_view.frame = [
          [0, org_y],
          [view.frame.size.width, picker_view.frame.size.height]
      ]
      p_view.showsSelectionIndicator = true
      p_view.selectRow(0, inComponent: COMPONENT_ID, animated: false)
      p_view.accessibilityLabel = PICKER_VIEW_ACC_LABEL
      view.addSubview(p_view)
    end
  end

  def offset_origin_y
    y = 0
    y += UIApplication.sharedApplication.statusBarFrame.size.height
    y += self.navigationController.navigationBar.bounds.size.height if self.navigationController
    puts " ↓↓ PickerViewのY方向のOffsetを[#{y}]確保します。" if BW2.debug?
    y
  end
end
