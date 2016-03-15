class SessionsController < Devise::SessionsController

  skip_before_filter :must_be_logged_in!, except: :destroy

  def create_omniauth
    service = Service.find_or_create_by_authentication_hash(request.env['omniauth.auth'], current_user)
    sign_in :user, service.user
    redirect_to :tags
  end

end
