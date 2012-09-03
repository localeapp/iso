# iso

[![Build Status](https://secure.travis-ci.org/tigrish/iso.png)](http://travis-ci.org/tigrish/iso)

This project is a ruby implementation of ISO 639-1 alpha2 and ISO 3166-1. It includes definitions of all two letter language and region codes.

## Languages

Languages are defined by **ISO 639-1 alpha-2**; that is the 2 letter lowercase language code.

These have been augmented to contain the plural rule names and the language's direction.

	> ISO::Language.find('ru')
	
	=> #<ISO::Language:0x007fe2ba43db50
			@plural_rule_names=["one", "few", "many", "other"],
			@direction="ltr",
			@code="ru",
			@name="Russian">

## Regions

Regions are defined by **ISO 3166-1**; that is the 2 letter uppercase region code.

	> ISO::Region.find('MX')
	
	=> #<ISO::Region:0x007fe2ba070e50
			@code="MX",
			@name="Mexico"> 
	
## Tags

The combination of a language and a region is called a Tag :

	> ISO::Tag.new('pt-BR')

	 => #<ISO::Tag:0x007fe2bb005b90 @code="pt-BR",
	 	 	@language=#<ISO::Language:0x007fe2ba256918
	 			@plural_rule_names=["one", "other"],
			  	@direction="ltr",
		  		@code="pt",
	  			@name="Portuguese">,
	 		@region=#<ISO::Region:0x007fe2ba412e28
				@code="BR",
				@name="Brazil">>
				
## I18n

Language and region names are internationalized - [contribute to the I18n project directly on Locale](http://www.localeapp.com/projects/1763) for any changes.