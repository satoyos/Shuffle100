class BeginnerReciteLayout < RecitePoemLayout
  INITIAL_MESSAGE = 'ここに色々とメッセージを書く'

  def layout
    super
    add UILabel, :message_label
  end

  def message_label_style
    self.message = INITIAL_MESSAGE
    #%ToDo: 続きはここの実装から！

  end

  def message
    get(:message_label).text
  end

  def message=(msg)
    get(:message_label).text = msg
  end
end