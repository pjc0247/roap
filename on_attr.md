

반드시 구현해야 할 사항
----
* _super로 전달되는 method가 변경될 때
  (예: bind)
  변경된 메소드에 pure 메소드를 구현해야 함
  ```rb
  attr /foo/ do |base, method, md, rule|
    # ....
    bound_method = method.bind some_binding
    bound_method.define_singleton_method :pure do
      method.pure
    end
    # ....
  end
  ```
* on의 block에서 익셉션이 발생할 수 있으므로 캐치 후 디버그 정보를 출력

