class LandingController < ApplicationController
  # GET /countries
  # GET /countries.xml
  def index
    @platforms = Platform.find(:all)
    @providers = Provider.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def detail
    #@country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end
end
