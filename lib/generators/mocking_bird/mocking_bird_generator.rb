require 'fileutils'

class MockingBirdGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :klass, :type => :string, :default => ""
  argument :path, :type => :string, :default => ""

  def generate_mocking_bird
    target = path.present? ? path : "test/mocks"
    FileUtils.mkdir_p(target)
    mock_types.each do |type|
      file_path = File.join(path, "#{file_name}/#{klass}/#{type.to_s}.yml")
      description = "# Add #{file_name}::Client::#{klass} mock content here"
      create_file file_path, description  unless File.exist?(file_path)
    end
  end

  private

  def mock_types
    [:create, :read, :update, :delete]
  end
end
