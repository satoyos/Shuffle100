module StringWithUTF8Mac
  def ==(other)
    self.encode('UTF-8', 'UTF-8-Mac').eql? other.encode('UTF-8', 'UTF-8-Mac')
  end
end

class String
  prepend StringWithUTF8Mac
end
