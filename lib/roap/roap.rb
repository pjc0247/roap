module Roap
  @@rules = []

  def self.attr expr, &block
    @@rules.push({
      :expr => expr,
      :block => block })
  end
end

module Roap
  @@extensions = []
  def self.extensions
    @@extensions
  end

  module AttributeBase
    @@original_methods = {}

    def on expr, &block
      attrs = block.comment.empty? ?
        "runtime" : block.comment

      rules.push({
        :expr => expr,
        :block => block,
        :attrs => attrs})
    end
    def attr attr_name, &block
      
    end
    
    def get_pure base, method_name
      @@original_methods["#{base}::#{method_name}"]
    end

    def self.extended base
      local_rules = []
      
      base.__send__ :define_singleton_method, :rules do 
        local_rules
      end

      Roap::extensions.push base
    end
    def included base
      targets = []

      base.singleton_methods(false).each do |method_name|
        method = get_pure base, method_name
        method ||= base.singleton_method(method_name)

        targets.push({
          :type => :singleton_method,
          :name => method_name,
          :pure => method })
      end
      base.instance_methods(false).each do |method_name|
        method = get_pure base, method_name
        method ||= base.instance_method(method_name)

        targets.push({
          :type => :instance_method,
          :name => method_name,
          :pure => method })
      end

      targets.each do |target|
        pure = target[:pure]
        method_name = target[:name]
        type = target[:type]
        attr = target[:pure].comment
        attrs = []
  
        body = Roap::Utils::decomment pure.comment
        mds = body.scan /(@([^\n]+)\n((\s\s+[^\n]*\n?)*))/m
        mds.each do |match, key, value|
          attrs.push({:key=>key, :value=>value})
        end

        rules.each do |rule|
          mds = Roap::Utils::scanex attr, rule[:expr]

          mds.each do |md|
            on_rules = Roap.class_variable_get :@@rules
            
            on_rules.each do |on_rule|
              on_md = rule[:attrs].match on_rule[:expr]
              if on_md != nil
                # refresh method
                method = base.__send__ type, method_name
                @@original_methods["#{base}::#{method.name}"] ||= method

                method.define_singleton_method :pure do 
                  @@original_methods["#{base}::#{method.name}"]
                end
                method.define_singleton_method :attrs do 
                  attrs
                end

                on_rule[:block].call base, method, md, rule                
              end
            end

            break if rule[:attrs].match /^#\s*once/
          end
        end
      end

    end
  end
end