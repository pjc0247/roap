# roap
Aspect Oriented Programming for Ruby

Usage
----
```rb
module ChainExtension
  extend Roap::AttributeBase
  
  on /chain/ do |_super, md, *args|
    _super.call *args
    self
  end
end
```
```rb
module FilterExtension
  extend Roap::AttributeBase
  
  on /throw-if-not=(?<expr>.*)/ do |_super, md, *args|
    if args[0] == md[:expr]
      _super.call *args
    else
      throw "invalid argument #{args[0]}, expected #{md[:expr]}"
    end
  end
end
```
```rb
class Foo
  
  #chain
  def foo a
    puts "foo(#{a})"
  end
  
  #throw-if-not=hello
  def bar msg
    puts "bar(#{msg})"
  end
  
  #chain
  #throw-if-not=multi-attributes-test
  def zoo msg
    puts "zoo(#{msg})"
  end
  
  include ChainExtension
  include FilterExtension
end
```
```rb
a = Foo.new

a.foo(1)
 .foo(2)
 .foo(3)

a.bar("hello")
a.bar("bye") # error
```
