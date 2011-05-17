require 'country_iso_translater.rb'

def country_code_to_name(x)
  SunDawg::CountryIsoTranslater.translate_iso3166_alpha2_to_name x
end
def country_name_to_code(x)
  SunDawg::CountryIsoTranslater.translate_iso3166_name_to_alpha2 x
end

