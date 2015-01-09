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