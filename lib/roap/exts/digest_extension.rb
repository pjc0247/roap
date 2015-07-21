require 'digest'

module Roap
  module DigestExtension
    extend Roap::AttributeBase
    
    def get_param_index method, name
      idx = method.pure.parameters.index [:req, name.to_sym]
      
      if idx == nil
        raise ArgumentError, "parameter '#{md[:key]}' not found"
      end

      idx
    end

    on /sha1-digested (?<key>.*)/ do |_super, md, *args|
      idx = get_param_index _super, md[:key]

      args[idx] = Digest::SHA1.hexdigest args[idx]

      _super.call *args
    end
    on /sha256-digested (?<key>.*)/ do |_super, md, *args|
      idx = get_param_index _super, md[:key]

      args[idx] = Digest::SHA256.hexdigest args[idx]

      _super.call *args
    end
    on /md5-digested (?<key>.*)/ do |_super, md, *args|
      idx = get_param_index _super, md[:key]
      
      args[idx] = Digest::MD5.hexdigest args[idx]

      _super.call *args
    end
  end  
end
