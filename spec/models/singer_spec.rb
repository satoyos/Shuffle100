describe 'Singer' do
  INIT_HASH = {
      id: :ia,
      name: 'IA（ボーカロイド）',
      path: 'resources/audio/ia'
  }
  describe '初期化' do
    before do
      @singer = Singer.new(INIT_HASH)
    end
    it 'should be a valid object' do
      @singer.should.not.be.nil
    end
    it '初期化時に与えたプロパティを保持する' do
      INIT_HASH.keys.each do |key|
        @singer.send(key).should == INIT_HASH[key]
      end
    end
  end

  describe 'self.singers' do
    it 'should be an Array of Singer' do
      Singer.singers.tap do |ss|
        ss.is_a?(Array).should.be.true
        ss.size.should == 2
        ss.first.is_a?(Singer).should.be.true
      end
    end
  end

  describe 'self.default_singer' do
    it 'should be a 1st singer' do
      Singer.default_singer.tap do |s|
        s.is_a?(Singer).should.be.true
        s.id.should == Singer::SINGERS_DATA.first[:id]
      end
    end
  end

  describe 'self.get_idx_of_singer_id' do
    it '正しいindexを取得する' do
      Singer.get_idx_of_singer_id(:ia).should == 0
    end
  end

  describe 'self.get_singer_of_id' do
    it '正しいSingerオブジェクト(IA)を取得する' do
      Singer.get_singer_of_id(:ia).tap do |singer|
        singer.is_a?(Singer).should.be.true
        singer.id.should == :ia
      end
    end
    it '正しいSingerオブジェクト(いなばくん)を取得する' do
      Singer.get_singer_of_id(:inaba).tap do |singer|
        singer.is_a?(Singer).should.be.true
        singer.id.should == :inaba
      end
    end
  end
end

