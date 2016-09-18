class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer
      .permit(:sign_up,
              keys: [:kpp, :ogrn, :company_name, :head, :init_date,
                     :region, :city, :address, :zipcode, :phone])
  end
end