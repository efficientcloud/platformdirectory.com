class Provider < ActiveRecord::Base
  has_permalink :name, :status

  has_many :country, :through => :providers_countries
  has_many :platform, :through => :providers_platform
  belongs_to :status

  def to_param
    slug
  end
end
