class Status < ActiveRecord::Base
  has_permalink :name, :slug

  def to_param
    permalink
  end
end
