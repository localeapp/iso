require 'i18n'
I18n.load_path << Dir[File.join(File.expand_path(File.dirname(__FILE__) + '/../locales'), '*.yml')]
I18n.load_path.flatten!

require_relative 'iso/tag'
require_relative 'iso/subtag'
require_relative 'iso/language'
require_relative 'iso/region'
require_relative 'iso/un/region'
