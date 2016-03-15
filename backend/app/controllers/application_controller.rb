class ApplicationController < ActionController::Base
  force_ssl if: :ssl_configured?

  protect_from_forgery with: :exception

  helper_method :logged_in?, :is_admin?
  # before_action :dev_mode, if: -> { Rails.env.development? }
  before_action :find_network
  before_action :load_trending_tags
  before_action :load_active_users
  before_action :clear_legacy_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :date_of_birth, :gender) }
  end

  private

  # Reset session for user logged in before deploying devise changes
  # could be removed later on
  def clear_legacy_user
    session[:user_id] = nil if session[:user_id].present?
  end

  def require_admin!
    redirect_to :root unless is_admin?
  end

  def is_admin?
    current_user.try(:admin?)
  end

  def must_be_logged_in!
    redirect_to :root unless logged_in?
  end

  # def current_user=(user)
  #   session[:user_id] = user.try(:id)
  # end

  # def current_user
  #   return @current_user if defined?(@current_user)
  #   @current_user = session[:user_id] ? ::User.find_by_id(session[:user_id]) : nil
  # end

  def logged_in?
    signed_in?
  end

  # def dev_mode
  #   if params[:dev] == "login"
  #     self.current_user = User.first
  #   end
  # end

  def load_trending_tags
    @trending_tags = Tag.for_network(@network).displayable.recently_active.limit(30)
  end

  def find_network
    @network = params[:network]
  end

  def ssl_configured?
    false
  end

  def load_active_users
    @active_users = User.joins(:active_tags).includes(:active_tags)
      .where("tags.id IS NOT NULL").order("messages.created_at DESC")
      .limit(25)
  end

  def set_admin_timezone
    Time.zone = 'Eastern Time (US & Canada)'
  end
end
