require 'csv'
require 'open-uri'

CSV::Reader.parse(File.open('/Users/fin/Downloads/paas overview structure.csv', 'rb'), ',') do |row|
  if row[0] == 'name' or not row[0]
    next
  end


  slug = PermalinkFu.escape row[0]

  provider = Provider.find_by_slug slug
  if not provider
    provider = Provider.new({:slug => slug })
  end
  provider.name = row[0]
  provider.url = row[6]
  
  provider.platforms = (row[2] || '').downcase.split(',').map { |x| Platform.find_by_slug_or_create(x.strip) }
  provider.platforms.reject! {|x| x.slug == nil}

  puts provider.platforms.map {|x| x.slug}

  provider.country = (row[3] || '').downcase.split(',').map { |x| Country.find_by_code_or_create(x.strip) }
  provider.country.reject! {|x| x.code == nil}
  puts provider.country.map {|x| x.code}


  if provider.image.index('default') != nil and row[8]
    puts 'fetching logo'
    logopath = row[8]
    if logopath
      logoextension = logopath.last(3)

      open('public/images/providers/%s.%s' % [slug, logoextension], 'wb').write(open(logopath).read)
    end
  else
    puts 'skipped logo fetching'
  end

  provider.save()
end
