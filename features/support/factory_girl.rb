# encoding: utf-8
require "factory_girl"

module FactoryGirl
  def self.reload_definitions #:nodoc:
    self.factories.clear
    definition_file_paths.each do |path|
      load("#{path}.rb") if File.exists?("#{path}.rb")

      if File.directory? path
        Dir[File.join(path, '*.rb')].each do |file|
          load file
        end
      end
    end
  end
end

# Require factories...
#require 'spec/factories'

# Then define steps based on factories.
# COLISION WITH PICKLE
 require 'factory_girl/step_definitions'
