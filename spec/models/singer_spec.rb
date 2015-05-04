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
end

