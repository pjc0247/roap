module Roap
  attr /static/ do |base, method, md, rule|
    begin
      define_singleton_method :__comments__ do 
        return method.pure.comment
      end
      method.attrs.each do |attr|
        define_singleton_method "__#{attr[:key]}__".to_sym do 
          attr[:value]
        end
      end

      instance_exec base, method, md, &rule[:block]
    rescue Exception=>e
      raise e
    end
  end
end