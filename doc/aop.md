Aspect Oriented Programming
====

```rb
class Auth

  def on_login  id, pw
    if not id.length.between? 8, 16 or
       not pw.length.between? 8, 16
      # ArgumentException
    end
    
    digested_pw = Digest::SHA256.hexdigest pw
    
    send_login id, digested_pw
  end
end
```

```rb
class Auth
  
  # @restrictions
  #    id => length(8..16)
  #          typeof(String)
  #    pw => length(8..16)
  #          typeof(String)
  #--sha256-digested pw
  def on_login id, pw
    send_login id, pw
  end
  
  include Roap::AllExtensions
end
```
