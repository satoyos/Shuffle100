describe 'SelectedState100' do
  INITIAL_STATUS = SelectedStatus100::INITIAL_STATUS
  describe '初期化' do
    describe 'Context: 選択状態配列を与えずに初期化' do
      before do
        @status100 = SelectedStatus100.new(nil)
      end

      it 'should not be nil' do
        @status100.should.not.be.nil
      end

      it 'INITIAL_STATEで指定された選択状態で初期化されている' do
        @status100[0].should == INITIAL_STATUS
        @status100[15].should == INITIAL_STATUS
      end
    end

    describe 'Context: 選択状態配列を与えて初期化' do
      before do
        array = (1..100).to_a.map{false}
        array[3]  = true
        array[25] = true
        @status100 = SelectedStatus100.new(array)
      end

      it 'should not be nil' do
        @status100.should.not.be.nil
      end

      it '正しく初期化されていることを確認' do
        @status100[2].should.be.false
        @status100[25].should.be.true
      end

    end

    describe 'Context: Booleanで初期化' do
      it 'falseで初期化したら、全てfalseの配列で初期化した場合と同じになる。' do
        status100 = SelectedStatus100.new(false)
        status100.size.should == SelectedStatus100::SIZE
        status100.inject(false){|bool, status| bool || status}.should.be.false
      end
      it 'trueで初期化したら、全てtrueの配列で初期化した場合と同じになる。' do
        status100 = SelectedStatus100.new(true)
        status100.inject(true){|bool, status| bool && status}.should.be.true
      end

    end
  end

  describe 'Forwardableモジュールを使ってdelegateしたメソッドのテスト' do
    before do
      @status100 = SelectedStatus100.new(nil)
    end

    it 'should support []=' do
      @status100[10].should == INITIAL_STATUS
      @status100[10] = !INITIAL_STATUS
      @status100[10].should == !INITIAL_STATUS
    end

    it 'should support size()' do
      @status100.size.should == SelectedStatus100::SIZE
    end
  end

  describe 'of_number' do
    before do
      @status100 = SelectedStatus100.new(nil)
      @status100[15] = !INITIAL_STATUS
    end

    it '[]のindexよりも1多い数のindexでアクセスする' do
      @status100.of_number(15).should == INITIAL_STATUS
      @status100.of_number(16).should == !INITIAL_STATUS
    end

=begin
    it 'idxの値が異常値の場合は例外になる' do
     should.raise{ @status100.of_number(-1)}
     should.raise{ @status100.of_number(101)}
    end
=end

  end

  describe 'set_status:of_number:' do
    before do
      @status100 = SelectedStatus100.new(nil)
      @status100.set_status(!INITIAL_STATUS, of_number: 15)
    end

    it '[]=のindexよりも1多い数のindexでアクセスする' do
      @status100[14].should == !INITIAL_STATUS
    end
  end

  describe 'cancel_all' do
    before do
      @status100 = SelectedStatus100.new(nil)
      @status100[10] = true
    end

    it '選択状態は全てfalseになる' do
      @status100.cancel_all
      @status100.inject(false){|bool, status| bool || status}.should.be.false
    end
  end

  describe 'select_all' do
    before do
      @status100 = SelectedStatus100.new(nil).cancel_all
    end

    it '選択状態は全てtrueになる' do
      @status100.select_all.inject(true){|bool, status|
        bool && status
      }.should.be.true
    end
  end

  describe 'select_in_number' do
    before do
      @status100 = SelectedStatus100.new(nil).cancel_all
      @status100.select_in_number(10)
    end

    it '指定された番号の選択状態をtrueにする' do
      @status100.of_number(10).should == true
    end
  end

  describe 'cancel_in_number' do
    before do
      @status100 = SelectedStatus100.new(nil).select_all
      @status100.cancel_in_number(3)
    end

    it '指定された番号の選択状態をfalseにする' do
      @status100.of_number(3).should == false
    end
  end


  describe 'selected_num' do
    before do
      @status100 = SelectedStatus100.new(nil).cancel_all
      @status100[1] = true
      @status100[10] = true
    end

    it 'trueが設定されている個数を返す' do
      @status100.selected_num.should == 2
    end
  end

  describe 'select_in_numbers' do
    before do
      @status100 = SelectedStatus100.new(nil).cancel_all
      @status100.select_in_numbers(1..3)
    end

    it '与えられたコレクションに格納されている番号の選択状態をtrueにする' do
      @status100.selected_num.should == 3
      @status100.of_number(2).should.be.true
    end
  end

  describe 'cancel_in_numbers' do
    before do
      @status100 = SelectedStatus100.new(nil).select_all
      @status100.cancel_in_numbers([40, 50])
    end

    it '与えられたコレクションに格納されている番号の選択状態をtrueにする' do
      @status100.selected_num.should == 98
      @status100.of_number(40).should.be.false
    end
  end

  describe 'reverse_in_index' do
    before do
      @status100 = SelectedStatus100.new(nil).select_all
      @status100.reverse_in_index(4)
    end

    it '指定された配列インデックスの選択状態を反転させる' do
      @status100[4].should.be.false
    end
  end

  describe 'reverse_in_number' do
    before do
      @status100 = SelectedStatus100.new(nil).select_all
      @status100.reverse_in_number(10)
    end

    it '指定された歌番号の選択状態を反転させる' do
      @status100.of_number( 9).should.be.true
      @status100.of_number(10).should.be.false
      @status100.of_number(11).should.be.true
    end
  end

  describe '#clone' do
    before do
      @status100 = SelectedStatus100.new(nil).select_all
      @clone = @status100.clone
    end
    it 'should not be same object of original' do
      @status100.should.not == @clone
    end
    it 'cloneしたオブジェクトの内部データを変更しても、オリジナルには影響しない' do
      @clone.cancel_all
      @status100.selected_num.should == 100
      @clone.selected_num.should == 0
    end
  end
end