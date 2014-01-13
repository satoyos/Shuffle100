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
      @supplier.player.should.be.nil
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

      describe 'playerの確認' do
        before do
          @supplier.draw_next_poem
        end
        it 'AVAudioPlayerオブジェクトを保持している' do
          @supplier.player.should.not.be.nil
          @supplier.player.is_a?(AVAudioPlayer).should.be.true
        end

        # Travis CIを通すため、無効にする
=begin
        it 'playerは再生可能' do
          @supplier.player.play
          @supplier.player.playing?.should.be.true
        end
=end
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
end