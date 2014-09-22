require 'yaml'
module MockingBird
  class Mock
    attr_accessor :mock_set

    def initialize(file, klass)
      @file = file
      @mock_set = {}
      @klass = klass
      load_mock if @file.present?
    end

    private

    def load_mock
      case File.extname(@file)
        when '.yml'  then load_yaml
        else nil
      end
    end

    def load_yaml
      objects = YAML::load_file(@file)
      objects = objects.with_indifferent_access if objects.present?
      Hash(objects|| nil).each do |k,v|
        @mock_set[k.to_sym] = @klass.set_test_results(Array(v[:results]),v[:conditions]).first if v[:results] && v[:conditions]
      end
      @mock_set
    end

    def method_missing(method, *args, &block)
      if match = method.to_s.match(/^(.*)=$/)
        raise NoMethodError
      elsif has_mock?(method)
        @mock_set[method]
      else
        raise NoMethodError
      end
    end

    def has_mock?(name)
      @mock_set.has_key?(name.to_sym)
    end


  end
end