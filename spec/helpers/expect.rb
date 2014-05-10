module Bacon

  class Context
    def expect(obj)
      Bacon::Should.new(obj)
    end
  end

end

class Should

  def to
    self
  end

end