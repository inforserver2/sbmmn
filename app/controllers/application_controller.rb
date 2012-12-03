class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :uri

  private


  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end


  helper_method :current_user

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end


  def sponsor
    @sponsor ||= User.member(request.subdomains.last)
  end
  helper_method :sponsor

  def uri
    if sponsor.subdomain != request.subdomains.last
      site=MySub.new request, sponsor
      redirect_to site.url
    else
      unless session[:visit]
#      sponsor.visit_counter.inc
      session[:visit]=true
      end
    end
  end


end
