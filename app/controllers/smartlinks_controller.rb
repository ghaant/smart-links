class SmartlinksController < ApplicationController
  before_action :valid_slug, only: :redirect
  before_action :logged_in, except: :redirect

  def redirect
    if (smartlink = Smartlink.find_by(slug: params[:slug]))
      redirections = smartlink.redirections.joins(:language)
      if (url = redirections.find_by('languages.code = ?', request.accept_language[0..1])&.url)
        redirect_to url
      elsif (default_url = redirections.find_by("languages.default = 'true'")&.url)
        redirect_to default_url
      else
        redirect_to home_path, alert: 'Neither a smartlink with your nrowser language nor default one for this slug is found'
      end
    else
      redirect_to home_path, alert: 'There is no smartlink with this slug'
    end
  end

  def index
    current_user.smartlinks if logged_in?
  end

  def new
    @smartlink = Smartlink.new
  end

  def create
    @smartlink = current_user.smartlinks.new(slug: smartlink_params[:slug])
    language = Language.find_or_initialize_by(code: smartlink_params[:language_code])
    @smartlink.redirections.new(smartlink: @smartlink, language: language, url: smartlink_params[:url])

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
    redirect_to root_path, alert: 'Invalid slug' unless params[:slug].match(VALID_SLUG)
  end

  def smartlink_params
    params.require(:smartlink).permit(:slug, :language_code, :url)
  end

  def logged_in
    redirect_to login_path, alert: 'Please login first' unless logged_in?
  end
end
