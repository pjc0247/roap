module Roap
  module LogExtension
    extend Roap::AttributeBase
    
    on /log-before (?<format>.*)/ do |_super, md, *args|
      puts md[:format] % {
        :name => _super.pure.name,
        :location => _super.pure.source_location }
      
      _super.call *args
    end

    on /log-after (?<format>.*)/ do |_super, md, *args|
      result = _super.call *args

      puts md[:format] % {
        :name => _super.pure.name,
        :location => _super.pure.source_location }

      result
    end
  end  
end
