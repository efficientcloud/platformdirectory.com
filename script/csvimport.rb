#!/usr/bin/env rails runner

require 'csv'
require 'open-uri'

CSV::Reader.parse(File.open('PlatformDirectory.com Data Source.csv', 'rb'), ',') do |row|
  if row[0] == 'name' or not row[0]
    next
  end

  slug = PermalinkFu.escape row[0]
  
  provider = Provider.find_by_slug slug
  provider ||= Provider.new({:slug => slug })
  
  provider.name = row[0]
  provider.url = row[5]
  provider.logo_is_dark = (row[8] == 'dark')
  
  provider.platforms = (row[2] || '').downcase.split(',').map { |x| Platform.find_or_create(x.strip) }
  provider.platforms.reject! {|x| x.slug == nil}
  
  provider.country = (row[3] || '').downcase.split(',').map { |x| Country.find_by_code_or_create(x.strip) }
  provider.country.reject! {|x| x.code == nil}

  provider.description = row[6]

  if provider.image.index('default') != nil and row[7]
    puts 'fetching logo'
    logopath = row[8]
    if logopath
      logoextension = logopath.last(3)

      open('public/images/providers/%s.%s' % [slug, logoextension], 'wb').write(open(logopath).read) rescue nil
    end
  else
    puts 'skipped logo fetching'
  end

  provider.save
end
