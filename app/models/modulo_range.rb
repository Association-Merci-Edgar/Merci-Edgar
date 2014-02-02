class ModuloRange
  
  def initialize(start_index, last_index, modulo=12)
    if start_index <= last_index
      @array = Range.new(start_index, last_index).to_a
    else
      @array = Range.new(start_index, modulo).to_a
      array2 = Range.new(1,last_index).to_a
      @array.push(*array2)
    end
  end
  
  def to_a
    @array
  end
end