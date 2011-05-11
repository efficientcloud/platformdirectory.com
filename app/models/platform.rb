class Platform < ActiveRecord::Base
  has_permalink :name, :slug

  has_many :provider, :through => :providers_platforms

  def to_param
    slug
  end
  
  def image
    if File.exists?('public/images/platforms/%s.png' % @slug)
      return '/images/platforms/%s.png' % @slug
    else
      return '/images/platforms/default.png'
    end
  end

  def self.find_by_slug_or_create(slug)
    x  = find_by_slug(slug)
    if x != nil
      return x
    end
    return create(:name => slug)
  end
end
