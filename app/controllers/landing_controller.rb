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
    puts params
    redirect_to filteredlist_path :platform => params[:platform], :country => country_name_to_code(params[:country][:name]).downcase
  end

  def list
    @platforms = params[:platform]?[Platform.find_by_slug(params[:platform])]:Platform.find(:all)
    @countrys = params[:country]?[Country.find_by_code(params[:country])]:Country.find(:all)
    if params[:platform]
      @country = Country.find_by_code params[:country]
      @platform = Platform.find_by_slug params[:platform]
      @providers = Provider.joins(:country).joins(:platforms).find(:all, :conditions => {
        :countries => {:code => @country.code},
        :platforms => {:slug => @platform.slug},
      })
    else
      @providers = Provider.find(:all)
    end
    @platform = nil

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
