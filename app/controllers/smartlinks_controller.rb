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

  private

  def valid_slug
    redirect_to home_path, alert: 'Invalid slug' unless params[:slug].match(VALID_SLUG)
  end
end
