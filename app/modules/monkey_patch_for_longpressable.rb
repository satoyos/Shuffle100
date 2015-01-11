module ProMotion
  module Table
    module Longpressable

=begin
      def make_longpressable(params={})
        params = {
            min_duration: 1.0
        }.merge(params)

        long_press_gesture = UILongPressGestureRecognizer.alloc.initWithTarget(self, action:"on_long_press:")
        long_press_gesture.minimumPressDuration = params[:min_duration]
        long_press_gesture.delegate = self
        self.table_view.addGestureRecognizer(long_press_gesture)
      end
=end

      def on_long_press(gesture)
        return unless gesture.state == UIGestureRecognizerStateBegan
        gesture_point = gesture.locationInView(table_view)
        if searching?
          puts '!! contentOffset of searchResutsView => '
          ap table_search_display_controller.searchResultsTableView.contentOffset
          gesture_point = point_on_scrolled_screen(gesture_point)
        end
        index_path = table_view.indexPathForRowAtPoint(gesture_point)
        puts '!! index_path => '
        ap index_path
        return unless index_path # <= これ、pull requestしていいかも？？
        data_cell = self.promotion_table_data.cell(index_path: index_path)
        return unless data_cell
        trigger_action(data_cell[:long_press_action], data_cell[:arguments], index_path) if data_cell[:long_press_action]
      end

      private

      def point_on_scrolled_screen(org_point)
        puts "- スクロールされている長さ(#{scroll_length})分だけgesture_pointを補正します。" if BW2.debug?
        CGPointMake(org_point.x, org_point.y + scroll_length)
      end

      def scroll_length
        table_search_display_controller.searchResultsTableView.contentOffset.y -
            @searching_offset_y
      end
    end
  end

  class TableData
    def cell(params={})
      params = index_path_to_section_index(params)
      table_section = params[:unfiltered] ? self.data[params[:section]] : self.section(params[:section])
      c = table_section[:cells].at(params[:index].to_i)
      unless c
        puts "！そのindex_pathにはセルが存在しません！！(#{params})" if BW2.debug?
        return nil
      end
      set_data_cell_defaults c
    end
  end
end