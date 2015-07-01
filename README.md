# roap
Aspect Oriented Programming for Ruby

Concept
----
* AOP for Ruby
* 주석을 이용한 메소드 Attribute 정의
  * 주석은 언어 문법에 구애받지 않기 때문에 자유로운 활용 가능

Goals
----
* 주석과 소스의 하이브리드
  * 주석에 작성된 값을 소스에서 활용
  * 메소드의 각 파라미터들에 대한 기본값, 제약 사항등을 주석에다도 적고, 소스에 또 적는건 멋지지 않다는 생각에서

Usage
----
확장 어트리뷰트를 정의할 모듈을 작성합니다.
```rb
module FooExtension
  extend Roap::AttributeBase
  
  # on
  #   
  #
  # /i-am-a-milkman/
  #    
  #
  # Arguments
  #   - _super  : 
  #   - md      : 
  #   - *args   :
  #
  # Return
  #   
  on /i-am-a-milkman/ do |_super, md, *args|
    puts "before"
      _super *args
    puts "after"
    
    "return_value"
  end
end
```

Example
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
  
  on /throw-if-not (?<key>.*)=>(?<value>.*)/ do |_super, md, *args|
    idx = _super.parameters.index([:req, md[:key].to_sym])
    if args[idx] == md[:value]
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
  
  #throw-if-not msg=>hello
  def bar msg
    puts "bar(#{msg})"
  end
  
  #chain
  #throw-if-not msg=>multi-attributes-test
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

Issues
----
* 패치되기 전의 메소드와 패치 후의 메소드의 method.parameters의 값이 다름
  * roap가 적용된 이후의 메소드는 parameters가 *p로 변경됨
