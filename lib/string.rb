class String
  def to_range
    case self.count('.')
    when 2
      elements = self.split('..')
      return Range.new(elements[0].to_i, elements[1].to_i)
    when 3
      elements = self.split('...')
      return Range.new(elements[0].to_i, elements[1].to_i-1)
    else
      raise ArgumentError.new("Couldn't convert to Range:
      #{str}")
    end
  end
end