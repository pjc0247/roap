module Roap
  module Utils
    def self.decomment src
      src.gsub! /^#*/, ""
    end

    def self.scanex str, regexp
      names = regexp.names.map! {|x| x.to_sym}
      str.scan(regexp).collect do |match|
        Hash[names.zip(match)]
      end
    end
  end
end