class ProvidersPlatform < ActiveRecord::Base
  belongs_to :provider
  belongs_to :platform
end
