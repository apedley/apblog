class SessionsController < ApplicationController
  def new
  end
  def create
		user = User.find_by_name(params[:name])
		if user && user.authenticate(params[:password])
			if params[:remember_me]
				cookies.permanent[:auth_token] = user.auth_token
			else
				cookies[:auth_token] = user.auth_token
			end
			
			redirect_to root_url, :notice => "logged in successfully"
		else
			flash.now.alert = "Invalid email or password"
			render "new"
		end
	end

	def destroy
		cookies.delete(:auth_token)
		redirect_to root_url, :notice => "logged out"
	end
end
