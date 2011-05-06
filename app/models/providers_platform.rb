class ProvidersPlatform < ActiveRecord::Base
  belongs_to :providers
  belongs_to :platform
end
