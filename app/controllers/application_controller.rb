class ApplicationController < ActionController::Base
  before_action  :set_locale, :authenticate_user!
  #protect_from_forgery with: :exception

  protect_from_forgery prepend: true
#  def set_locale
 #   I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    #if user_signed_in?
    #  I18n.locale = current_user.locale
   # end
 #   session[:locale] = I18n.locale
 # end

 # def default_url_options(options = {})
 #   { locale: I18n.locale }.merge options
 # end

 # def locale
  #  I18n.locale = params[:locale] || I18n.default_locale
 #   if current_user
 #     current_user.update!(locale: params[:locale])
  #  end
  #  redirect_to(request.env["HTTP_REFERER"])
 # end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
