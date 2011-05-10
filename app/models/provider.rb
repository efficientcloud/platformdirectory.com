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
    filename = '/images/providers/%s.*' % self.slug
    matching = Dir.glob 'public%s' % filename
    if matching.length > 0
      return matching[0].sub('/images','')
    else
      return '/images/providers/default.png'
    end
  end
end
