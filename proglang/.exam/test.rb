class A
  attr_accessor :x
  def m1
    @x = 4
  end
  def m2
    m1
    @x > 4
  end
  def m3
    @x = 4
    @x > 4
  end
  def m4
    self.x = 4
    puts "A: x=#{@x}"
    @x > 4
  end
end

class B < A
  def m1
    @x = 5
  end
  def m4
  	@x = 5
    puts "B: x=#{@x}"
  	super
  end
  def x=(val)
  	puts "B.x"
  	@x = val
  end
end

puts B.new.m2
puts B.new.m4