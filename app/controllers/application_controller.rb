class ApplicationController < ActionController::API
  before_action :authenticate_user!, except: [:new, :create]

  private

  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= authenticate_user_from_token
  end

  def authenticate_user_from_token
    user_id = decoded_token&.fetch('user_id', nil)
    User.find_by(id: user_id) if user_id
  end

  def user_signed_in?
    current_user.present?
  end

  def login(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def logout
    @current_user = nil
    reset_session
  end

  def encode_token(payload)
    JWT.encode(payload, 'yourSecret')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ').last
      begin
        JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
