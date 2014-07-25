class UsersController < ApplicationController
	def edit
		@user = current_user
	end

	def update
		if params[:user][:image]
			base64_encode = Base64.encode64(params[:user][:image].read)
			params[:user][:image] = base64_encode
		end
		@user = User.find(params[:id])
		@user.update_attributes(user_params)
		redirect_to home_path 
	end

	private 

	def user_params
		params.require(:user).permit(:first_name,:last_name,:image,:nick_name,:team_id)
	end
end
