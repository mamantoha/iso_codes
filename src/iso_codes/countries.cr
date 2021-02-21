module ISOCodes
  class Countries
    include JSON::Serializable

    forward_missing_to @countries

    @[JSON::Field(key: "3166-1")]
    private property countries : Array(Country)

    {% for key in %w(alpha_2 alpha_3 name numeric official_name common_name) %}
      def find_by_{{key.id}}(value : String) : Country?
        countries.find { |country| country.{{key.id}} == value }
      end
    {% end %}
  end

  class Country
    include JSON::Serializable

    property alpha_2 : String

    property alpha_3 : String

    property name : String

    property numeric : String

    property official_name : String?

    property common_name : String?

    def translation(language_code : String)
      ISOCodes::DataProvider.translations(:countries, language_code)[name]?
    end

    def to_s(io : IO) : Nil
      inspect(io)
    end
  end
end
