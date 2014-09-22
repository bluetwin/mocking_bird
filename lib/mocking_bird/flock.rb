require_relative 'bird'
module MockingBird
  class Flock
    attr_accessor :service, :birds

    def initialize(path = '')
      @birds = {}
      @path   = path
      @service = path.split("/").last.classify
      load if @path.present?
    end

    def clear_tests
      @birds.values do |bird|
        bird.clear_tests
      end
    end

    private

    def load
      Dir.entries(@path).each do |dir|
        spawn_birds(dir)
      end
    end

    def spawn_birds(dir)
      full_path = File.join(@path,dir)
      if File.directory?(full_path) && dir != ".." && dir != "."
        bird = Bird.new(:service => @service, :path => full_path)
        @birds[bird.klass.downcase.to_sym] = bird
      end
    end

    def method_missing(method, *args, &block)
      if match = method.to_s.match(/^(.*)=$/)
        raise NoMethodError
      elsif bird = has_bird?(method)
        @birds[method]
      else
        raise NoMethodError
      end
    end

    def has_bird?(klass)
      @birds.has_key?(klass)
    end
  end
end