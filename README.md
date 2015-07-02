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
  #   on 을 이용해서 Attribute를 정의할 수 있습니다.
  #
  # /i-am-a-milkman/
  #    주석에 대해 매칭시킬 정규식입니다.
  #
  # Arguments
  #   - _super  : 변경되기 이전의 메소드입니다.
  #   - md      : 정규식에 매칭된 매치데이터입니다.
  #   - *args   : 원래 메소드에 넘어온 인자들입니다.
  #
  # Return
  #   Ruby 문법 상 블록에서는 return 키워드를 사용할 수 없기 때문에
  #   블록의 가장 마지막에 리턴값을 위치시키는 방법으로 값을 리턴할 수 있습니다.
  on /i-am-a-milkman/ do |_super, md, *args|
    puts "before"
      _super *args
    puts "after"
    
    "return_value"
  end
end
```
각각의 Attribute들은 실행 순서가 보장되지 않습니다.<br>
따라서 항상 다른 어트리뷰트에 종속되지 않고 독립적인 로직을 작성해야 합니다.

Example
----
```rb
# chain 어트리뷰트를 통해 자동으로 메소드 체인을 구현해주는 확장 모듈
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
  * -> _super.pure 구현으로 해결 / _super.pure은 다른 훅들에 의해 dirty 상태가 되기 전의 바닐라 메소드를 리턴한다.


DAT
----
* https://github.com/pjc0247/roap_test_helper
