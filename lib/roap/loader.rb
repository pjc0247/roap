module Roap
  def self.require_all cwd, path
    Dir["#{cwd}/#{path}/*.rb"].each do |file|
      require file
    end
  end
end