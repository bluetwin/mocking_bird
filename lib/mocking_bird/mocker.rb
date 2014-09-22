require_relative 'flock'
module MockingBird
  class Mocker
    cattr_accessor :path, :flocks

    class << self
      def setup_mocks(options = {})
        # iterate over mocks and create birds in teh flock
        @flocks = {}
        @path = options.fetch(:path, default_directory)
        load_mocks if @path
      end

      def load_mocks
        Dir.entries(@path).each do |dir|
          full_path = File.join(@path,dir)
          if File.directory?(full_path) && dir != ".." && dir != "."
            flock = Flock.new(full_path)
            @flocks[flock.service.downcase.to_sym] = flock
          end
        end
      end

      def clear_mocks
        @flock.values do |flock|
          flock.clear_test_results
        end
      end

      private

      def default_directory
        Rails.root.join('test','mocks')
      end

      def method_missing(method, *args, &block)
        if match = method.to_s.match(/^(.*)=$/)
          super
        elsif has_flock?(method)
          @flocks[method]
        else
          nil
        end
      end

      def has_flock?(name)
        @flocks.keys.include? name
      end
    end

  end
end