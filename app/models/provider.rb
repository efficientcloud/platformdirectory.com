class Provider < ActiveRecord::Base
  has_permalink :name, :slug

  has_many :providers_countries
  has_many :providers_platforms
  has_many :country, :through => :providers_countries
  has_many :platforms, :through => :providers_platforms
  belongs_to :status

  def to_param
    slug
  end

  def image
    if File.exists?('public/images/providers/%s.png' % @slug)
      return '/images/providers/%s.png' % @slug
    else
      return '/images/providers/default.png'
    end
  end
end
