class LandingController < ApplicationController
  # GET /countries
  # GET /countries.xml
  def index
    @platforms = Platform.find(:all)
    @providers = Provider.find(:all)
    @platform = nil

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
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
      format.html { render 'index' }
      format.xml  { render :xml => @country }
    end
  end
end
