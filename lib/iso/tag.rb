module ISO
  class Tag
    attr_accessor :language, :region

    def initialize(code)
      @code     = code
      @language = Language.identify(code)
      @region   = Region.identify(code) || UN::Region.identify(code)
    end

    def codes
      subtags.map(&:code)
    end

    def subtags
      [language, region].compact
    end

    def valid?
      return false if @language.nil?
      @code.split('-').size == subtags.size
    end
  end
end
