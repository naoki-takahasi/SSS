class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters , if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Brewery
      brewery_my_page_path(current_brewery)
    when Shop
      shop_my_page_path(current_shop)
    when Admin
      admin_root_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :brewery
      root_path
    when :shop
      root_path
    when :admin
      new_admin_session_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :post, :address, :tel])
  end
end
