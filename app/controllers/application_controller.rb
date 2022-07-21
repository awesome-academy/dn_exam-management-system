class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_locale, :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception, if: ->{request.format.json?}
  protect_from_forgery with: :null_session, if: ->{request.format.json?}

  prepend_before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def configure_permitted_parameters
    attributes = [:first_name, :last_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logined_in?
    return if user_signed_in?

    flash[:danger] = t ".you_need_to_login"
    redirect_to :login
  end

  def load_per_page per_page
    params[:size] ||= per_page
  end

  def not_found
    flash[:danger] = t "layouts.application.not_found"
    redirect_to root_path
  end
end
