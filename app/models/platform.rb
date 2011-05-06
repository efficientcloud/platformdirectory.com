class Platform < ActiveRecord::Base
  has_permalink :name, :slug

  has_many :provider, :through => :providers_platforms

  def to_param
    permalink
  end
end
