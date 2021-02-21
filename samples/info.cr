require "../src/iso_codes"

countries = ISOCodes.countries
languages = ISOCodes.languages

puts "#{countries.size} Country codes (`ISO 3166-1` - 2 letter) in #{ISOCodes::DataProvider::COUNTRY_TRANSLATION_CODES.size} Languages"
puts "#{languages.size} Language codes (`ISO_639-2` - 2 letter) in #{ISOCodes::DataProvider::LANGUAGE_TRANSLATION_CODES.size} Languages"
