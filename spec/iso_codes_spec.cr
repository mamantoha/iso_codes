require "./spec_helper"

describe ISOCodes do
  describe ISOCodes::Language do
    it "list of langeages" do
      languages = ISOCodes.languages
      languages.should be_a(ISOCodes::Languages)
    end

    it "forward_missing_to @languages" do
      languages = ISOCodes.languages

      language = languages.find { |l| l.alpha_2 == "pt" }
      language.try(&.name).should eq("Portuguese")
    end

    it ".find_by_name" do
      languages = ISOCodes.languages

      language = languages.find_by_name("English")
      language.should be_a(ISOCodes::Language)
      language.try(&.alpha_2).should eq("en")
    end

    it ".find_by_alpha_2" do
      languages = ISOCodes.languages

      language = languages.find_by_alpha_2("fr")
      language.should be_a(ISOCodes::Language)
      language.try(&.name).should eq("French")
    end

    it ".find_by_alpha_3" do
      languages = ISOCodes.languages

      language = languages.find_by_alpha_3("tlh")
      language.should be_a(ISOCodes::Language)
      language.try(&.name).should eq("Klingon; tlhIngan-Hol")
    end

    context "translations" do
      it "translate" do
        languages = ISOCodes.languages

        language = languages.find_by_name("English")
        translation = language.try(&.translation("fr"))
        translation.should eq("anglais")
      end

      it "raise exception if translation not found" do
        languages = ISOCodes.languages

        language = languages.find_by_name("English")

        expect_raises(ISOCodes::NoTranslationAvailable, "for `languages` and language code `zz`") do
          language.try(&.translation("zz"))
        end
      end
    end
  end

  describe ISOCodes::Country do
    it "list of countries" do
      countries = ISOCodes.countries
      countries.should be_a(ISOCodes::Countries)
    end

    it "forward_missing_to @countries" do
      countries = ISOCodes.countries

      country = countries.find { |c| c.name == "United States" }
      country.try(&.alpha_2).should eq("US")
    end

    it ".find_by_name" do
      countries = ISOCodes.countries

      country = countries.find_by_name("Ukraine")
      country.should be_a(ISOCodes::Country)
      country.try(&.alpha_2).should eq("UA")
    end

    it ".find_by_alpha_2" do
      countries = ISOCodes.countries

      country = countries.find_by_alpha_2("CY")
      country.should be_a(ISOCodes::Country)
      country.try(&.name).should eq("Cyprus")
      country.try(&.alpha_3).should eq("CYP")
      country.try(&.numeric).should eq("196")
      country.try(&.official_name).should eq("Republic of Cyprus")
    end

    it ".find_by_alpha_3" do
      countries = ISOCodes.countries

      country = countries.find_by_alpha_3("DEU")
      country.should be_a(ISOCodes::Country)
      country.try(&.name).should eq("Germany")
    end

    it ".find_by_flag" do
      countries = ISOCodes.countries

      if country = countries.find_by_flag("🇺🇦")
        country.should be_a(ISOCodes::Country)
        country.alpha_2.should eq("UA")
      end
    end

    it ".flag" do
      countries = ISOCodes.countries

      if country = countries.find_by_alpha_2("UA")
        country.flag.should eq("🇺🇦")
      end
    end

    context "translations" do
      it "translate" do
        countries = ISOCodes.countries

        country = countries.find_by_alpha_2("UA")
        translation = country.try(&.translation("it"))
        translation.should eq("Ucraina")
      end

      it "raise exception if translation not found" do
        countries = ISOCodes.countries

        country = countries.find_by_alpha_2("UA")

        expect_raises(ISOCodes::NoTranslationAvailable, "for `countries` and language code `zz`") do
          country.try(&.translation("zz"))
        end
      end
    end
  end

  describe ISOCodes::DataProvider do
    it "cache @@translations" do
      countries = ISOCodes.countries
      languages = ISOCodes.languages

      country = countries.find_by_alpha_2("UA")
      country.try(&.translation("it"))

      language = languages.find_by_name("English")
      language.try(&.translation("fr"))

      translations = ISOCodes::DataProvider.translations

      translations.has_key?("countries_it").should be_truthy
      translations.has_key?("languages_fr").should be_truthy
    end

    it "COUNTRY_TRANSLATION_CODES" do
      ISOCodes::DataProvider::COUNTRY_TRANSLATION_CODES.includes?("zh_TW").should be_truthy
    end

    it "LANGUAGE_TRANSLATION_CODES" do
      ISOCodes::DataProvider::LANGUAGE_TRANSLATION_CODES.includes?("pt_BR").should be_truthy
    end
  end
end
