class ISO::Region < ISO::Subtag
  DEFINITIONS_FILE = "#{File.dirname(__FILE__)}/../../data/iso-3166-1.yml"
  UN_M49_FILE      = "#{File.dirname(__FILE__)}/../../data/un-m49.yml"

  def initialize(code, options={})
    if code =~ /\d{3}/ && iso_code = ISO::Region.un_m49_codes.fetch(code)
      super(iso_code, options)
    else
      super(code, options)
    end
  end

  def self.identify(full_code)
    full_code =~ /[-_]([A-Z]{2})$/ ? find($1) : nil
  end

  def self.un_m49_codes
    @un_m49_codes ||= YAML.load_file(self::UN_M49_FILE)
  end

private

  def i18n_scope
    super << ".regions"
  end
end
