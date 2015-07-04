Digest
====

Ruby stdlib의 Digest모듈을 roap에서 사용할 수 있도록 제작된 확장입니다.<br>
[Ruby Digest](http://ruby-doc.org/stdlib-2.1.0/libdoc/digest/rdoc/Digest.html)


sha1-digested param_name
----
파라미터를 SHA1로 해시하여 받습니다.<br><br>

__param_name__<br>
해시할 파라미터의 이름입니다.

```rb
class Foo
  
  #sha1-digested password
  def login id, password
    # ...
  end
  
  include Roap::DigestExtension
end
```

sha256-digested param_name
----
파라미터를 SHA256으로 해시하여 받습니다.<br><br>

__param_name__<br>
해시할 파라미터의 이름입니다.

md5-digested param_name
----
파라미터를 MD5로 해시하여 받습니다.<br><br>

__param_name__
해시할 파라미터의 이름입니다.
