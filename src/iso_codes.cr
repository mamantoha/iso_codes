require "json"
require "./emoji_flag"
require "./iso_codes/*"

module ISOCodes
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  class NoTranslationAvailable < Exception
  end

  def self.countries
    ISOCodes::DataProvider.countries
  end

  def self.languages
    ISOCodes::DataProvider.languages
  end
end
