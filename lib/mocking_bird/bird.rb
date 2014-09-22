require_relative 'mock'
module MockingBird

  class Bird

    attr_accessor :mocks, :service, :klass

    def initialize(opts = {})
      @service = opts.fetch(:service)
      @path    = opts.fetch(:path)
      @klass   = @path.split("/").last.classify
      @mocks   = {}

      load_actions if @path.present?
    end

    def client_klass
      @client_klass ||= "#{@service}::Client::#{@klass}".constantize
    end

    def clear_tests
      client_klass.clear_test_results
    end

    private

    def load_actions
      regex = File.join(@path,'*.yml')
      Dir.glob(regex).each do | mock_file |
        load_mocks(mock_file)
      end
    end

    def load_mocks(mock_file)
      action = File.basename(mock_file, ".*")
      mock = Mock.new(mock_file, client_klass)
      @mocks[action.downcase.to_sym] = mock
    end

    def method_missing(method, *args, &block)
      if match = method.to_s.match(/^(.*)=$/)
        raise NoMethodError
      elsif has_mock?(method)
        @mocks[method]
      else
        raise NoMethodError
      end
    end

    def has_mock?(type)
      @mocks.has_key? type
    end


  end
end