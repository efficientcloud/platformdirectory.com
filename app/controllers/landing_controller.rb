class LandingController < ApplicationController
  # GET /countries
  # GET /countries.xml

  def index
    @platforms = Platform.find :all
    @countries = Country.find :all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def filter
    redirect_to filteredlist_path :platform => params[:platform], :country => country_name_to_code(params[:country][:name]).downcase
  end

  def list
    @platforms = Platform.find :all
    if params[:platform]
      @platform = Platform.find_by_slug params[:platform]
      @providers = Provider.joins(:country).joins(:platforms).find(:all, :conditions => {
        :platforms => {:slug => @platform.slug},
      })
    else
      @providers = Provider.find(:all)
      @platform = nil
    end

    if params[:country]
      @country = Country.find_by_code(params[:country])
      @country = @country?(@country.attributes):({'name' => country_code_to_name(params[:country].upcase), 'code' => params[:country]})

      @local_providers = @providers.select{|p| p.country.select{|c| c.code==@country['code']}}
      @local_platforms = @providers.map{|x| x.platforms}.flatten().uniq
    end


    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def detail
    @platforms = Platform.find(:all)


    p = Platform.find_by_slug(params[:slug])
    if p
      @platform = p
      @providers = p.providers
    end
    #@country = Country.find(params[:id])

    respond_to do |format|
      format.html { render 'list' }
    end
  end
end
