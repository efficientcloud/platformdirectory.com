class LandingController < ApplicationController
  def index
    @platforms = Provider.find(:all, :include => [:platforms]).map{|x| x.platforms}.flatten.uniq
    @countries = Country.find :all
    
    @client_country = GeoIP.new('GeoIP.dat').country(request.remote_ip).country_name rescue nil
    @client_country = nil if @client_country == "N/A"
    @client_country ||= "Germany"
  end

  def filter
    if params[:platform].length==0
      params[:platform] = 'list'
    end
    redirect_to filteredlist_path(:platform => params[:platform]||'list', :country => country_name_to_code(params[:country][:name]).downcase)
  end

  def list
    @platforms = Platform.find(:all, :include => [:providers]).select{|x| x.providers.length>0}
    @providers = Provider.find(:all, :include => [:platforms, :country])

    if params[:country]
      @country = Country.find_by_code(params[:country])
      @country = @country?(@country.attributes):({'name' => country_code_to_name(params[:country].upcase), 'code' => params[:country]})

      @local_providers = @providers.select{|p| p.country.select{|c| c.code==@country['code']}.length>0}
      @local_platforms = @local_providers.map{|x| x.platforms}.flatten().uniq
    end

    if params[:platform] and params[:platform]!='list'
      @platform = Platform.find_by_slug params[:platform]
      @providers = @providers.select{|p| p.platforms.include?(@platform)}
      if params[:country]
        @local_providers = @local_providers.select{|p| p.platforms.include?(@platform)}
      end
    else
      @platform = nil
    end
  end

  def detail
    if Platform.find_by_slug(params[:slug])
      params[:platform] = params[:slug]
      list
      render :action => 'list'
    end
    if (x = Provider.find_by_slug(params[:slug]))
      redirect_to x.url
    end
  end
end
