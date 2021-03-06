class Country < ActiveRecord::Base
  def image
    filename = '/images/countries/%s.png' % self.code.downcase
    if File.exists?('public%s' % filename)
      return filename
    else
      return '/images/countries/default.png'
    end
  end
  
  def self.find_by_code_or_create(code)
    if code == nil
      return nil
    end
    x  = find_by_code(code)
    if x != nil
      x.name = country_code_to_name(code.upcase)
      x.save
      return x
    end
    return create(:code => code, :name => country_code_to_name(code.upcase))
  end
end
