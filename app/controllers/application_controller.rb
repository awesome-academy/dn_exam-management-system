class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception, if: ->{request.format.json?}
  protect_from_forgery with: :null_session, if: ->{request.format.json?}

  prepend_before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from CanCan::AccessDenied, with: :access_denied

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

  def access_denied
    if current_user.nil?
      flash[:danger] = t ".access_denied_login"
      return redirect_to signin_path
    end

    flash[:danger] = t ".access_denied"
    redirect_to root_path
  end

  def load_per_page per_page
    params[:size] ||= per_page
  end

  def not_found
    flash[:danger] = t "layouts.application.not_found"
    redirect_to root_path
  end
end
