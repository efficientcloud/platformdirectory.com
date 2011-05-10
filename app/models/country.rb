class Country < ActiveRecord::Base
  def image
    filename = '/images/countries/%s.png' % @code.downcase
    if File.exists?('public%s' % filename)
      return filename
    else
      return '/images/countries/default.png'
    end
  end
end
