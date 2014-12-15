class Person
  attr_accessor :name, :age, :job
  def initialize(name="unknown", age="unknown", job="unknown")
    @name, @age, @job = name, age, job
  end
  def i_am
    print "I am #{@name} and I am #{@age} years old and I am employed as a #{@job}"
  end
end
