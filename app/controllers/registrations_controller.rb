class RegistrationsController < Devise::RegistrationsController
  def create
        
    build_resource(sign_up_params)
    emailadd = params[:user][:email]
    location = emailadd.index('@')
    temp = emailadd.slice(0,location)
    resource.userid = temp   #******** here resource is user
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  protected
  def after_inactive_sign_up_path_for(resource)
    '/users/sign_in'
  end

  def after_sign_up_path_for(resource)
    '/admin/setUserId'
  end

  
end