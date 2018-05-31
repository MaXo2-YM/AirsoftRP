class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
    	@user = User.new
	end

	def create
    	@user = User.new
		@user.username = params[:user][:username]
		@user.mail = params[:user][:mail]
		@user.inscription_date = Time.now
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]
    	if @user.save
    		flash[:notice] = "Vous vous êtes bien inscrit"
        	flash[:color]= "valid"
			redirect_to "/users/#{@user.id}"
     	else
        	flash[:notice] = "Le formulaire est invalide"
        	flash[:color]= "invalid"
			render 'new'
     	end
	end

	def show
		@user = User.find(params[:id])
	end

	def update
		User.find(params[:id]).update mail: params[:mail]
		User.find(params[:id]).update last_name: params[:last_name]
		User.find(params[:id]).update first_name: params[:first_name]
		if params[:password] != ''

		end
		redirect_to "/users/#{params[:id]}"
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to "/users"
	end
end
