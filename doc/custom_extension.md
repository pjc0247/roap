확장 어트리뷰트 만들기
====

```rb
module GreetingExtension
  extend Roap::AttributeBase
  
  #runtime
  on /greeting (?<prefix>.*)/ do |_super, md, *args|
    puts "#{md[:prefix]} #{args[0]}"
    
    _super.call *args
  end
end
```

GreetingExtension을 사용할 클래스를 제작합니다.<br>
기본적으로는 로그인 기능을 제공하는 클래스로, GreetingExtension을 이용하여, 이용자가 로그인 할 때 마다 인사 메세지를 출력하는 기능을 주입합니다.
```rb
class LoginService

  #--greeting hi, 
  def login name
    # ....
  end
  
  include GreetingExtension
end
```
```rb
obj = LoginService.new

obj.login "park" #=> hi, park
```
