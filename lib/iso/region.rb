class ISO::Region < ISO::Subtag
  DEFINITIONS_FILE = "#{File.dirname(__FILE__)}/../../data/iso-3166-1.yml"
  UN_M49_FILE = "#{File.dirname(__FILE__)}/../../data/un-m49.yml"

  def self.identify(full_code)
    full_code =~ /[-_]([A-Z]{2})$/ ? find($1) : nil
  end

  def self.new(code, options={})
    return super unless code =~ /\d{3}/
    country_code_or_name = un_m49_region_from_number(code)
    return super(country_code_or_name, options) if country_code_or_name.length == 2
    return super(code, options.merge(name: country_code_or_name ))
  end

private

  def self.un_m49_region_from_number(number)
    all_un_m49s[number]
  end
  private_class_method :un_m49_region_from_number

  def self.all_un_m49s
    @all_un_m49s ||= YAML.load_file(self::UN_M49_FILE)
  end
  private_class_method :all_un_m49s

  def i18n_scope
    super << ".regions"
  end
end
