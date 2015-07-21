module Roap
  module AllExtensions
    def self.included base
      Roap::extensions.each do |ext|
        base.include ext
      end
    end
  end
end