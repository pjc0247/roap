
메소드 내부에서 \__attr_name__을 사용하여 주석의 각 항목에 접근할 수 있습니다.<br>

```rb
# @parameters
#   a => DAT A
#   b => DAT b
# @return
#   DATDATDAT
def foo a,b
  puts __parameters__
  puts __return__
end
```

동일한 이름을 가진 어트리뷰트가 있을 경우 가장 아래의 값이 반환됩니다.<br>
```rb
# @foo
#   1234
# @foo
#   123456
def foo
  __foo__ #=> 123456
end
```

\__comments__는 전체 주석을 반환합니다.

```rb
# @foo
#   12345
#qwerweqr
# @bar
#   asdf
def foo
  __comments__
end
```
