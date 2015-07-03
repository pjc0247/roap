
메소드 내부에서 \__attr_name__을 사용하여 주석의 각 항목에 접근할 수 있습니다.<br>
\__comments는 전체 주석을 반환합니다.

```rb
# @parameters
#   a => DAT A
#   b => DAT b
# @return
#   DATDATDAT
def foo a,b
  puts __comments__
  
  puts __parameters__
  puts __return__
end
```
