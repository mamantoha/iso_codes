module ISOCodes
  module DataProvider
    extend self

    @@translations = {} of String => Hash(String, String)

    @@countries : Countries = Countries.from_json(json(:countries))
    @@languages : Languages = Languages.from_json(json(:languages))

    DATA_DEST = "#{__DIR__}/../../data"

    JSON_CODES = {
      :countries => "iso_3166-1.json",
      :languages => "iso_639-2.json",
    }

    TRANSLATIONS = {
      :countries => "iso_3166-1/",
      :languages => "iso_639-2/",
    }

    COUNTRY_TRANSLATION_CODES =
      Dir.glob("#{DATA_DEST}/#{TRANSLATIONS[:countries]}/*.po").map { |path| Path[path].basename(".po") }

    LANGUAGE_TRANSLATION_CODES =
      Dir.glob("#{DATA_DEST}/#{TRANSLATIONS[:languages]}/*.po").map { |path| Path[path].basename(".po") }

    def countries
      @@countries
    end

    def languages
      @@languages
    end

    def translations(type, language_code)
      @@translations["#{type}_#{language_code}"] ||= begin
        path = TRANSLATIONS[type] + "#{language_code}.po"

        unless File.exists?("#{DATA_DEST}/#{path}")
          raise NoTranslationAvailable.new("for `#{type}` and language code `#{language_code}`")
        end

        data = get(path)

        data = data.split("\n")

        po_to_hash(data)
      end
    end

    def translations
      @@translations
    end

    private def json(type)
      get(JSON_CODES[type])
    end

    private def get(path)
      File.read("#{DATA_DEST}/#{path}")
    end

    private def po_to_hash(data) : Hash(String, String)
      names = data.select { |l| l =~ /^msgid/ }.map { |line| line.match(/^msgid "(.*?)"/).try(&.[1]) }
      translations = data.select { |l| l =~ /^msgstr/ }.map { |line| line.match(/^msgstr "(.*?)"/).try(&.[1]) }

      names.map_with_index do |name, index|
        [name.to_s, translations[index].to_s]
      end.to_h
    end
  end
end
