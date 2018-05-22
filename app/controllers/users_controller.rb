class UsersController < ApplicationController
	require 'digest/sha1'
	def index
		@users = User.all
	end
	
	def create
		User.create mail: params[:mail]
		redirect_to "/users"
	end
	
	def show
		@user = User.find(params[:id])
	end
	
	def update
		User.find(params[:id]).update mail: params[:mail]
		User.find(params[:id]).update last_name: params[:last_name]
		User.find(params[:id]).update first_name: params[:first_name]
		if params[:password] != ''
			salt = Digest::SHA1.hexdigest("# We add #{params[:mail]} as unique value and #{Time.now} as random value")
			User.find(params[:id]).update salt: salt
			encrypted_password= Digest::SHA1.hexdigest("Adding #{salt} to #{params[:password]}")
			User.find(params[:id]).update encrypted_password: encrypted_password
		end
		redirect_to "/users/#{params[:id]}"
	end
	
	def destroy
		User.find(params[:id]).destroy
		redirect_to "/users"
	end
end
