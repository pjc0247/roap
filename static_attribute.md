on이 실행되는 시점을 메소드 호출 타임이 아니라 스태틱 타임(?)으로 변경할 수도 있습니다.<br>

확장 속성을 정의할 때 __static__ 속성을 이용

```rb
module FooExtension
  extend Roap::AttributeBase
  
  #static
  on /test-me (?<should>.*)/ do |klass, method, md|
    should = eval(md[:should])
    
    if should != klass.method(method).call
      puts "test silpae"
    end
  end
end
```
```rb
class Foo
  #test-me 10
  def self.jinoo_iq
    10
  end
end
```
