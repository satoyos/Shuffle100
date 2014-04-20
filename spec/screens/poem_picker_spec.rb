describe 'PoemPicker' do
  describe '初期化' do
#    tests PoemPicker

    def controller
      @controller ||= PoemPicker.new.init_members
    end
    alias :screen :controller


    it 'should not be nil' do
      screen.should.not.be.nil
    end

    it 'has 100 poems' do
      screen.poems.should.not.be.nil
      screen.poems.size.should == 100
      screen.poems.first.is_a?(Poem).should.be.true
    end

    it 'has 100 selected_status' do
      screen.status100.should.not.be.nil
      screen.status100.size.should == 100
    end
  end
end
