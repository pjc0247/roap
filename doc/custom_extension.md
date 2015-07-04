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
