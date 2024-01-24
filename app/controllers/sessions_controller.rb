class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:name])

    if user && user.authenticate(params[:name]) 
      login user
      render json: { message: 'Login successful', user: user }
    else
      render json: { error: 'Invalid username' }, status: :unauthorized
    end
  end

  def destroy
    logout
    render json: { message: 'Logout successful' }
  end
end