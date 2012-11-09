require 'i18n'
I18n.load_path << Dir[File.join(File.expand_path(File.dirname(__FILE__) + '/../locales'), '*.yml')]
I18n.load_path.flatten!

require 'iso/tag'
require 'iso/subtag'
require 'iso/language'
require 'iso/region'
require 'iso/un/region'
