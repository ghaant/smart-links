class SmartlinksController < ApplicationController
  before_action :valid_slug, only: :redirect

  def redirect
    if (smartlink = Smartlink.find_by(slug: params[:slug]))
      redirections = smartlink.redirections.joins(:language)
      if (url = redirections.find_by('languages.code = ?', request.accept_language[0..1]).url)
        redirect_to url
      else
        redirect_to redirections.find_by("languages.default = 'true'").url
      end
    else
      redirect_to home_path, alert: 'There is no smartlink with this slug'
    end
  end

  def index
    current_user.smartlinks
  end

  def new
    @smartlink = Smartlink.new
  end

  def create
    @smartlink = Smartlink.new(smartlink_params)

    respond_to do |format|
      if @smartlink.save
        format.html { redirect_to smartlinks_path, notice: 'Smartlink was successfully created.' }
        format.json { render :index, status: :created, location: @smartlink }
      else
        format.html { render :new }
        format.json { render json: @smartlink.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Smartlink.find(params[:id]).destroy
    redirect_to smartlinks_path, notice: 'Smartlink deleted'
  end

  private

  def valid_slug
    redirect_to home_path, alert: 'Invalid slug' unless params[:slug].match(VALID_SLUG)
  end

  def smartlink_params
    params.require(:smartlink).permit(:slug, :language, :url)
  end
end
