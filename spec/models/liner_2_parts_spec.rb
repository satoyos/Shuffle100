INIT_HASH_L2 = {kami: '花さそふ嵐の庭の雪ならで',
                shimo: 'ふりゆくものはわが身なりけり'}

describe Liner_2_parts do
  describe 'initialize' do
    before do
      @l2p = Liner_2_parts.new(INIT_HASH_L2)
    end
    it 'should not be nil' do
      @l2p.should.not.be.nil
    end

    it 'should have 上の句 as 「花さそふ嵐の庭の雪ならで」' do
      @l2p.kami.should.be.equal '花さそふ嵐の庭の雪ならで'
    end

    it 'should have 下の句 as 「ふりゆくものはわが身なりけり」' do
      @l2p.shimo.should.be.equal 'ふりゆくものはわが身なりけり'
    end
  end

  describe 'to_s' do
    before do
      @l2p = Liner_2_parts.new(INIT_HASH_L2)
    end
    it '上の句と下の句を、半角スペースを挟んで連結した文字列を返す' do
      @l2p.to_s.tap do |s|
        s.should.not.be.nil
        s.should == "#{@l2p.kami} #{@l2p.shimo}"
      end

    end
  end
end