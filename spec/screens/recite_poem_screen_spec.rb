

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

=begin
    it 'プロパティとしてrp_viewを持つ' do
      screen.rp_view.should.not.be.nil
    end
=end
  end

  it 'should not rotate' do
    screen.should_autorotate.should.be.false
  end

=begin
  it 'allow renewing layout' do
    screen.create_new_layout
    1.should == 1
  end
=end


end
