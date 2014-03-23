describe 'Deck' do
  describe 'initialize' do
    shared 'a valid Deck' do
      it 'should be a valid Deck' do
        @deck.should.not.be.nil
        @deck.is_a?(Deck).should.be.true
      end
    end
    context '枚数指定無しで初期化' do
      before do
        @deck = Deck.new
      end

      behaves_like 'a valid Deck'

      it '枚数は100枚' do
        @deck.size.should == 100
      end

    end

    context '枚数を10枚に指定して初期化' do
      before do
        @deck = Deck.new(10)
      end

      behaves_like 'a valid Deck'

      it '枚数は10枚' do
        @deck.size.should == 10
      end

      it '歌番号は1番から10番' do
        @deck.poems.map{|poem| poem.number}.should == (1..10).to_a
      end
    end
  end

  describe 'クラスメソッド original_deck' do
    before do
      @deck = Deck.original_deck
    end

    it 'should not be nil' do
      @deck.should.not.be.nil
    end

    it '百枚のオリジナルデッキ' do
      @deck.size.should == 100
      @deck.poems.first.is_a?(Poem).should.be.true
      @deck.poems.first.number.should == 1
    end
  end

  describe 'poems' do
    before do
      @poems = Deck.new.poems
    end

    it 'should be an array of poem object' do
      @poems.is_a?(Array).should.be.true
      @poems[0].is_a?(Poem).should.be.true
    end

    it 'should have 100 element' do
      @poems.size.should.be.equal 100
#      RubyMotionでは、この↓書き方はできない。(ERRORになる)
#      @poems.should.have(100).items
    end

    it 'has first Poem that is No.1 and made by "天智天皇"' do
      first_poem = @poems[0]
      first_poem.number.should.be.equal 1
      first_poem.poet.should.be.equal '天智天皇'
      first_poem.liner[1].should.be.equal 'かりほの庵の'
    end

    it 'has 2nd Poem that is No.2 and made by "持統天皇"' do
      second_poem = @poems[1]
      second_poem.number.should.be.equal 2
      second_poem.poet.should.be.equal '持統天皇'
      second_poem.in_hiragana.shimo.should.be.equal 'ころもほすてふあまのかくやま'
    end
  end

  describe 'size' do
    before do
      @deck = Deck.new
    end

    it '保持しているPoemの数を返す' do
      @deck.size.should.not.be.nil
      @deck.size.should == @deck.poems.size
    end
  end

  describe 'counter and next_poem' do
    before do
      @deck = Deck.new
    end

    it 'counterの初期値は0' do
      @deck.counter.should.not.be.nil
      @deck.counter.should == 0
    end

    it 'next_poemで次のPoemオブジェクトを取得できる' do
      @deck.next_poem.should.not.be.nil
      @deck.next_poem.is_a?(Poem).should.be.true
    end

    it 'シャッフルも選別もしていないDeckの場合、最初に#1の歌が、次に#2の歌が取得できる' do
      first_poem = @deck.next_poem
      first_poem.poet.should == "天智天皇"
      second_poem = @deck.next_poem
      second_poem.in_hiragana.shimo.should == 'ころもほすてふあまのかくやま'
    end

    it 'next_poemを呼ぶと、counterの値が一つ増えなければならない' do
      @deck.next_poem
      @deck.counter.should == 1
    end

    it 'next_poemによってPoemを取得し尽くした場合、next_poemはnilを返す' do
      @deck.size.times {@deck.next_poem}
      @deck.counter.should == @deck.size
      @deck.next_poem.should.be.nil
    end

  end

  describe 'rollback_prev_poem' do
    before do
      @deck = Deck.new
      2.times {@deck.next_poem}  # 2枚めくっておく(2首進めておく)
    end

    it 'この状態で、counterの値は2' do
      @deck.counter.should == 2
    end

    it '1回ロールバックすると、カウンターの値は1になり、歌番号は1番になる' do
      prev_poem = @deck.rollback_poem
      @deck.counter.should == 1
      prev_poem.number.should == 1
    end

    it '2回ロールバックすると、カウンターの値は0になり、Poemはnilが返る' do
      prev_poem = @deck.rollback_poem
      prev_poem.should.not.be.nil
      @deck.rollback_poem.should.be.nil
      @deck.counter.should == 0

    end
  end

  describe 'shuffle_with_size:' do
    before do
      @deck = Deck.new.shuffle_with_size(10)
    end

    it 'should not be nil' do
      @deck.should.not.be.nil
      @deck.size.should == 10
    end

    it '10回歌データを供給できる' do
      10.times do
        @deck.next_poem.should.not.be.nil
      end
    end

    it '11回めの歌を供給しようとすると、nilを返す' do
      10.times do
        @deck.next_poem
      end
      @deck.next_poem.should.be.nil
    end
  end

  describe 'shuffle' do
    before do
      @deck = Deck.new.shuffle
      @numbers1 = @deck.poems.map{|poem| poem.number}
    end

    it 'should not be nil' do
      @deck.should.not.be.nil
      @deck.should.be.kind_of(Deck)
    end

    it 'change orders of poem' do
      numbers2 = @deck.shuffle.poems.map{|poem| poem.number}
      numbers2.size.should == @numbers1.size
      numbers2.should.not == @numbers1
    end
  end

  describe 'create_from_bool100:' do
    before do
      bool100 = SelectedStatus100.one_side_array_of(false)
      bool100[0] = true
      bool100[99] = true
      @deck = Deck.create_from_bool100(bool100)
    end

    it 'should not be nil' do
      @deck.should.not.be.nil
    end

    it '要素100のtrue/false配列で、trueを設定した歌だけが選択されている' do
      @deck.size.should == 2
    end
  end

  describe 'add_fake_poems' do
    context '取り札の数が3の場合' do
      before do
        bool100 = SelectedStatus100.one_side_array_of(false)
        bool100[1] = bool100[3] = bool100[5] = true
        @deck = Deck.create_from_bool100(bool100).add_fake_poems
      end
      it '3枚の空札が追加された、合計6枚のデッキを生成する' do
        @deck.size.should == 6
        @deck.poems.first.is_a?(Poem).should.be.true
      end
    end

    context '取り札の数が60の場合' do
      before do
        bool100 = SelectedStatus100.one_side_array_of(false)
        (0..59).each{|i| bool100[i] = true}
        @deck = Deck.create_from_bool100(bool100).add_fake_poems
      end
      it '空札を追加した後は、100枚のデッキができる' do
        @deck.size.should == 100
        @deck.poems.last.is_a?(Poem).should.be.true
      end
    end
  end

end
