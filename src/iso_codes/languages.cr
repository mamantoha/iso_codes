module ISOCodes
  class Languages
    include JSON::Serializable

    forward_missing_to @languages

    @[JSON::Field(key: "639-2")]
    private property languages : Array(Language)

    {% for key in %w(alpha_2 alpha_3 name common_name bibliographic) %}
      def find_by_{{key.id}}(value : String) : Language?
        languages.find { |language| language.{{key.id}} == value }
      end
    {% end %}
  end

  class Language
    include JSON::Serializable

    property alpha_2 : String?

    property alpha_3 : String

    property name : String

    property common_name : String?

    property bibliographic : String?

    def translation(language_code : String)
      ISOCodes::DataProvider.translations(:languages, language_code)[name]?
    end

    def to_s(io : IO) : Nil
      inspect(io)
    end
  end
end
