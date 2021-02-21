# ISO Codes

[![Crystal CI](https://github.com/mamantoha/iso_codes/actions/workflows/crystal.yml/badge.svg)](https://github.com/mamantoha/iso_codes/actions/workflows/crystal.yml)
[![GitHub release](https://img.shields.io/github/release/mamantoha/iso_codes.svg)](https://github.com/mamantoha/iso_codes/releases)
[![License](https://img.shields.io/github/license/mamantoha/iso_codes.svg)](https://github.com/mamantoha/iso_codes/blob/master/LICENSE)

This project provides lists of various ISO standards (`ISO 3166-1` for countries and `ISO 639-2` for languages) with translations for Crystal programming language.

## ISO 3166-1

This lists the 2-letter country code and "short" country name. The
official ISO 3166-1 maintenance agency is ISO.

<http://www.iso.org/iso/country_codes>

## ISO 639-2

This lists the 2-letter and 3-letter language codes and language
names. The official ISO 639-2 maintenance agency is the Library of
Congress.

<http://www.loc.gov/standards/iso639-2/>

## Translations

* 249 Country codes (`ISO 3166-1` - 2 letter) in 158 Languages
* 486 Language codes (`ISO_639-2` - 2 letter) in 92 Languages

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     iso_codes:
       github: mamantoha/iso_codes
   ```

2. Run `shards install`

## Usage

```crystal
require "iso_codes"

countries = ISOCodes.countries

country = countries.find_by_alpha_2("TW")
# => #<ISOCodes::Country:0x7fcce33cbbc0 @alpha_2="TW", @alpha_3="TWN", @name="Taiwan, Province of China", @numeric="158", @official_name="Taiwan, Province of China", @common_name="Taiwan">

country.translation("zh_TW")
# => 中華民國

languages = ISOCodes.languages

language = languages.find_by_name("French")
# => #<ISOCodes::Language:0x7fcce33d9300 @alpha_2="fr", @alpha_3="fra", @name="French", @common_name=nil, @bibliographic="fre">

language.translation("fr")
# => français
```

## Development

Update data from <https://salsa.debian.org/iso-codes-team/iso-codes.git> to make changes available to users:

```
make update_data
```

## Contributing

1. Fork it (<https://github.com/mamantoha/iso_codes/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Anton Maminov](https://github.com/mamantoha) - creator and maintainer
