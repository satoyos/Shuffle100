describe 'PoemSupplier' do
  describe '初期化' do
    shared 'a valid PoemSupplier' do
      it 'should not be nil' do
        @supplier.should.not.be.nil
      end
      it 'should be a instance of PoemSupplier' do
        @supplier.is_a?(PoemSupplier).should.be.true
      end
    end

    before do
      @supplier = PoemSupplier.new
    end
    behaves_like 'a valid PoemSupplier'

    it '初期状態では、扱う歌の数は100' do
      @supplier.size.should == 100
    end

    it '初期状態では、current_indexは0' do
      @supplier.current_index.should == 0
    end

    it '初期状態では、扱っている歌は無い' do
      @supplier.poem.should.be.nil
      # @supplier.player.should.be.nil
      @supplier.kami?.should.be.nil
    end
  end

  describe 'draw_next_poem' do
    before do
      @supplier = PoemSupplier.new
    end

    context 'まだ次の歌がある時' do
      it 'current_indexをインクリメントし、trueを返す' do
        @supplier.current_index.should == 0
        @supplier.draw_next_poem.should.be.true
        @supplier.current_index.should == 1
      end

      describe 'poemの確認' do
        before do
          @supplier.draw_next_poem
        end
        it 'Poemオブジェクトを保持している' do
          @supplier.current_index.should == 1
          @supplier.poem.should.not.be.nil
          @supplier.poem.number.should == 1
        end
        it 'あと2回めくると、保持する歌の番号は3になる' do
          2.times {@supplier.draw_next_poem}
          @supplier.current_index.should == 3
          @supplier.poem.number.should == 3
        end
      end

      describe 'kami?の確認' do
        before do
          @supplier.draw_next_poem
        end
        it '次の歌に移ってすぐは、上の句を管理している状態' do
          @supplier.kami?.should.be.true
        end
      end
    end

    context 'もう次の歌が無いとき' do
      before do
        @supplier = PoemSupplier.new
        100.times {@supplier.draw_next_poem} # 100回フルにめくる
      end
      it 'current_indexは100' do
        @supplier.current_index.should == 100
      end
      it 'falseを返す' do
        @supplier.draw_next_poem.should.be.false
      end
    end

  end

  describe 'rollback_prev_poem' do
    before do
      @supplier = PoemSupplier.new
      2.times {@supplier.draw_next_poem}  # 2枚めくっておく
    end

    it '1回ロールバックすると、current_indexは1になり、歌番号は1になる' do
      @supplier.rollback_prev_poem.should.be.true
      @supplier.current_index.should == 1
      @supplier.poem.number.should == 1
    end

    it '2回ロールバックすると、falseを返す' do
      @supplier.rollback_prev_poem.should.be.true
      @supplier.rollback_prev_poem.should.be.false
    end
  end

  describe '#step_into_shimo' do
    before do
      @supplier = PoemSupplier.new
      @supplier.draw_next_poem
    end

    it '管理対象が上の句から下の句に移行する' do
      @supplier.step_into_shimo
      @supplier.kami?.should.be.false
    end
  end

  describe '#side' do
    before do
      @supplier = PoemSupplier.new
      @supplier.draw_next_poem
    end

    it '上の句のときは、:kamiを返す' do
      @supplier.side.should == :kami
    end

    it '下の句に遷移した場合は :shimoを返す' do
      @supplier.step_into_shimo
      @supplier.side.should == :shimo
    end
  end

  describe 'バグ対策: 1枚目の上の句読み上げ中にrewindし、そこからforowad_skipしたら落ちた件' do
    before do
      @supplier = PoemSupplier.new
    end

    it 'もう落ちないよ！' do
      @supplier.draw_next_poem       # 1枚目をめくる
      @supplier.rollback_prev_poem.should.be.false   # 巻き戻そうとする
      @supplier.poem.should.be.nil
    end
  end
end