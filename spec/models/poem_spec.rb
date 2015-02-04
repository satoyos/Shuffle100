describe Poem do
  POEM_INIT_JSON =<<'EOF'
{
    "number": 2,
    "poet": "持統天皇",
    "living_years": "(645〜702)",
    "liner": [
      "春過ぎて",
      "夏来にけらし",
      "白妙の",
      "衣干すてふ",
      "天の香具山"
    ],
    "in_hiragana": {
      "kami": "はるすきてなつきにけらししろたへの",
      "shimo": "ころもほすてふあまのかくやま"
    },
    "in_modern_kana": [
      "はるすぎて",
      "なつきにけらし",
      "しろたえの",
      "ころもほすちょう",
      "あまのかぐやま"
    ],
    "kimari_ji": "はるす"
}
EOF

  JSON_WITH_SPACE =<<'EOF'
{
    "number": 11,
    "poet": "参議篁",
    "liner": [
      "和田の原",
      "八十島かけて",
      "漕ぎ出ぬと",
      "人にはつげよ",
      "あまのつりぶね"
    ],
    "in_hiragana": {
      "kami": "わたのはらやそしまかけてこきいてぬと",
      "shimo": "ひとにはつけよあまのつりふね"
    },
    "in_modern_kana": [
      "わたのはら",
      "やそしまかけて",
      "こぎいでぬと",
      "ひとにはつげよ",
      "あまのつりぶね"
    ],
    "kimari_ji": "わたのはら　や"
  }
EOF

  describe 'initialize' do
    describe 'Context: normal' do
      before do
        @hash = OH::JSONParser.parse(POEM_INIT_JSON)
        @poem = Poem.new(@hash)
      end

      it 'should be initialized by Hash data' do
        @hash.is_a?(Hash).should.be.true
      end
      it 'should not be nil' do
        @poem.should.not.be.nil
      end
      it 'should have"持統天皇" as poet' do
        @poem.poet.should.be.equal '持統天皇'
      end
      it 'should have liner data that consists of 5 parts' do
        @poem.liner.size.should.be.equal 5
      end
      it 'should have 決まり字「はるす」' do
        @poem.kimari_ji.should.be.equal 'はるす'
      end
      it '現代かなデータも正しく読み込める' do
        # @poem.in_modern_kana.should.not.be.nil
        expect(@poem.in_modern_kana).not.to.be.equal nil
        @poem.in_modern_kana[4].should == 'あまのかぐやま'
      end
      it '生年・没年データを正しく読み込める' do
        @poem.living_years.should == '(645〜702)'
      end
    end

    describe 'Context: 決まり字に全角スペースがある場合' do
      before do
        @poem2 = Poem.new(OH::JSONParser.parse(JSON_WITH_SPACE))
      end

      it 'should be a Poem' do
        @poem2.should.not.be.nil
      end

      it '決まり字の全角スペースは、Poemオブジェクト生成時に消える' do
        @poem2.kimari_ji.should.not =~ /　/
      end
    end
  end

  describe '#str_with_number_and_liner' do
    before do
      @hash = OH::JSONParser.parse(POEM_INIT_JSON)
      @str = Poem.new(@hash).str_with_number_and_liner
    end
    it 'should be a String' do
      @str.is_a?(String).should.be.true
    end
    it '歌番号と歌文字列からなる文字列を返す' do
      @str.should == '2. 春過ぎて 夏来にけらし 白妙の 衣干すてふ 天の香具山'
    end
  end
end