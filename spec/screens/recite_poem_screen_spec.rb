def opening_player
  UIApplication.sharedApplication.delegate.opening_player
end

describe 'RecitePoemController' do
  describe '初期化' do
    tests RecitePoemScreen

    it 'should be a valid controller' do
      controller.should.not.be.nil
      controller.is_a?(RecitePoemScreen).should.be.true
    end

    it 'プロパティとしてsupplierを持つ' do
      controller.supplier.should.not.be.nil
    end

    it 'プロパティとしてcurrent_playerを持つ' do
      controller.current_player.should.not.be.nil
    end
  end


end

