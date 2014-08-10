class BeginnerReciteLayout < RecitePoemLayout
  def layout
    super
    add UILabel, :message_label
  end

  def message_label_style
    #%ToDo: 続きはここの実装から！
  end
end