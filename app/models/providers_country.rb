class ProvidersCountry < ActiveRecord::Base
  belongs_to :providers
  belongs_to :country
end
