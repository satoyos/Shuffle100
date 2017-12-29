module FiveColors
  FIVE_COLOR_SYMBOLS = [:blue, :yellow, :green, :pink, :orange]

  # 各色の札番号
  YELLOW_NUMBERS = [ 2,  7, 10, 18, 32, 33, 37, 39, 46, 47, 55, 60, 78, 79, 81, 85, 87, 89, 94, 96]
  PINK_NUMBERS   = [ 1,  4, 13, 16, 22, 28, 34, 40, 48, 51, 58, 65, 66, 72, 73, 80, 83, 84, 86, 97]
  ORANGE_NUMBERS = [19, 21, 25, 27, 43, 44, 45, 49, 52, 53, 56, 63, 64, 67, 77, 88, 90, 95, 98, 99]
  BLUE_NUMBERS   = [ 3,  5,  6, 12, 14, 24, 30, 31, 50, 57, 61, 62, 69, 70, 74, 75, 76, 82, 91, 100]
  GREEN_NUMBERS  = [ 8,  9, 11, 15, 17, 20, 23, 26, 29, 35, 36, 38, 41, 42, 54, 59, 68, 71, 92, 93]

  # 各色の名前文字列
  BLUE_STR   = '青'
  YELLOW_STR = '黃'
  GREEN_STR  = '緑'
  PINK_STR   = '桃(ピンク)'
  ORANGE_STR = 'だいだい(オレンジ)'

  def numbers_of_color(color_sym)
    case color_sym
      when :blue;   BLUE_NUMBERS
      when :yellow; YELLOW_NUMBERS
      when :green;  GREEN_NUMBERS
      when :pink;   PINK_NUMBERS
      when :orange; ORANGE_NUMBERS
      else
        puts ("xxxx ERROR: [#{color_sym}]の色はサポートしていません。 xxxx") if BW2.debug?
        []
    end
  end

  def str_of_color(color_sym)
    case color_sym
      when :blue;   BLUE_STR
      when :yellow; YELLOW_STR
      when :green;  GREEN_STR
      when :pink;   PINK_STR
      when :orange; ORANGE_STR
      else
        purs("xxxx ERROR: [#{color_sym}]の色はサポートしていません。 xxxx") if BW2.debug?
        ''
    end
  end
end