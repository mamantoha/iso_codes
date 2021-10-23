require "../src/iso_codes"

puts "Country:"
if country = ISOCodes.countries.find_by_alpha_2("UA")
  puts country.inspect
  # => <ISOCodes::Country:0x7f4bd307e5a0 @alpha_2="UA", @alpha_3="UKR", @name="Ukraine", @numeric="804", @official_name=nil, @flag="🇺🇦", @common_name=nil>


  puts country.translation("pt")
  # => Ucrânia
end

puts "Language"
if language = ISOCodes.languages.find_by_name("Ukrainian")
  puts language.inspect
  # => #<ISOCodes::Language:0x7fcbd8d6a2c0 @alpha_2="uk", @alpha_3="ukr", @name="Ukrainian", @common_name=nil, @bibliographic=nil>

  puts language.translation("fr")
  # => ukrainien
end
