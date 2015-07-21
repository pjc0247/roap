require 'binding_of_caller'

module Roap
  attr /runtime/ do |base, method, md, rule|
    if method.class == UnboundMethod
      target = :define_method
    elsif method.class == Method
      target = :define_singleton_method
    end

    base.__send__ target, method.name do |*p|
      begin
        if method.class == UnboundMethod
          unbound = method
          method = unbound.bind self
          method.define_singleton_method :pure do
            unbound.pure
          end
          method.define_singleton_method :attrs do
            unbound.attrs
          end
        end
        
        define_singleton_method :__comments__ do 
          return method.pure.comment
        end
        method.attrs.each do |attr|
          define_singleton_method "__#{attr[:key]}__".to_sym do 
            attr[:value]
          end
        end

        instance_exec method, md, *p, &rule[:block]
      rescue Exception=>e
        puts e.backtrace[1][/`.*'/][1..-2]
        puts "on #{rule[:expr].inspect}"
        puts "class #{base.to_s}"
        puts "method #{method}"
        raise e
      end
    end
  end
end