describe 'NGramNumbers' do
  describe '初期化' do
    before do
      @numbers = NGramNumbers.new
    end

    it 'should not be nil' do
      @numbers.should.not.be.nil
    end

    it 'has 100 Poems' do
      @numbers.poems.size.should == 100
    end

    it 'has a list of numbers' do
      # リストの大きさは、1文字目になりうる文字数に、
      #   「一枚札」をまとめたリスト分の1を足した数になる。
      @numbers.list.size.should == NGramNumbers::FIRST_CHARS.keys.size + 1
      @numbers.list[:a].is_a?(Array).should.be.true
    end

  end

  describe 'リストを正しく作っている' do
    before do
      @list = NGramNumbers.new.list
    end

    it '「は」に対応するリストは、[2, 9, 67, 96]' do
      @list[:ha].sort.should == [2, 9, 67, 96]
    end

    it 'リストを全部足したら、1〜100までの番号が揃った配列になる' do
      array = []
      @list.each do |key, value_array|
        next if key == :just_one  #「一枚札」全体を表すKeyはスキップ。
        array += value_array
      end
      array.sort.should == (1..100).to_a
    end
  end

  describe 'クラスメソッドのテスト' do
    it '「あ」から始まる歌は16首' do
      NGramNumbers.of(:a).size.should == 16
    end
    it '「む」で始まる歌は1首だけ' do
      NGramNumbers.of(:mu).should == [87]
    end
    it 'indexes_ofは、歌番号ではなく、0起点のIndexデータを返す' do
      NGramNumbers.indexes_of(:ha).sort.should == [1, 8, 66, 95]
    end
  end

end