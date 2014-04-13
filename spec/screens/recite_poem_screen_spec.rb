

describe 'RecitePoemScreen' do
  tests RecitePoemScreen
  alias :screen :controller

  describe '初期化' do
    it 'should be a valid controller' do
      screen.should.not.be.nil
      screen.is_a?(RecitePoemScreen).should.be.true
    end

    it 'プロパティとしてsupplierを持つ' do
      screen.supplier.should.not.be.nil
    end

    it 'プロパティとしてcurrent_playerを持つ' do
      screen.current_player.should.not.be.nil
    end
  end

  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end

=begin
  describe '百枚通すテスト！' do
    before do
      # このテストでは、100枚のシャッフル無しのデッキを用意する。
      screen.change_supplier(PoemSupplier.new)
      @interval_time = UIApplication.sharedApplication.delegate.reciting_settings.interval_time
    end

    it 'Supplierが扱うデッキのサイズは100' do
      screen.supplier.size.should == 100
    end

    it '歌を再生して、強制的に終わらせる' do
      # 序歌
      screen.recite_poem
      puts '=序歌読み上げ中'
      wait 1 do
        tap 'forward'
        wait @interval_time + 1 do
          2.times{
            # ここでは上の句を読み上げ中
            puts '=上の句読み上げ中'
            screen.supplier.kami?.should.be.true
            tap 'forward'
            wait 0.5 do


              tap 'play_button'
              # ここでは下の句を読み上げ中
              puts '=下の句読み上げ中'
              screen.supplier.kami?.should.be.false
              tap 'forward'
              wait @interval_time + 1 do
                # next
              end
            end
          }
        end
      end
    end
  end
=end
end
