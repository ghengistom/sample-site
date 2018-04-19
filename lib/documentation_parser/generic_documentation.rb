module Generic
  class Documentation
    PROPERTY_TYPES = [:get, :both, :set]
    
    def initialize(options = Hash.new)
      @description = Array.new
      @parameters = Array.new
      @remarks = Array.new
      @results = Array.new
      @value = Array.new
      @property_type = :both
    end
    
    def dump
      @description = nil if @description.empty?
      @parameters = nil if @parameters.empty?
      @remarks = nil if @remarks.empty?
      @results = nil if @results.empty?
      @value = nil if @value.empty?
      
      output = {
        :description => @description,
        :parameters => @parameters,
        :remarks => @remarks,
        :results => @results,
        :value => @value,
        :property => @property_type
      }
      
      if @description || @parameters || @remarks || @results || @value
        return output
      else
        return nil
      end
      
      # puts output.inspect
    end
    
    def self.parse(string, options = Hash.new)
      dsl = self.new(options)
      dsl.instance_eval(string)
      dsl
    end
    
    def snippet(id, variables = Hash.new)
      snippet = Snippet.find_by_id(id)
      eval(snippet.code)
    end
    
    def parameter(name, type, description, options = Hash.new)
      hash = {
        :name => name,
        :type => type,
        :description => description,
        :options => options
      }
      @parameters << hash
    end
    
    def value(name, type, description, options = Hash.new)
      hash = {
        :name => name,
        :type => type,
        :description => description,
        :options => options
      }
      @value = [hash]
    end
    
    def result(name, type, options = Hash.new)
      language_type = [:net, :com]
      
      if options.has_key?(:language_type)
        language_type = [options[:language_type]] if [:net, :com].include?(options[:language_type])
      end
      
      if options[:codes]
        codes = Array.new        
        options[:codes].each do |c,d|
          codes << {:value => c, :description => d}
        end
      end
      
      hash = {
        :name => name,
        :type => type,
        :language_type => language_type,
        :codes => codes
      }
      @results << hash
    end
    
    def property(type)
      @property_type = PROPERTY_TYPES.include?(type.to_sym) ? type : :string
    end
    
    def description(string)
      @description << string
    end
    
    def remarks(string)
      @remarks << string
    end
  end
end