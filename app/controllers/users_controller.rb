class UsersController < ApplicationController

	def index
		if session[:user_id] && User.find(session[:user_id]).level == 0
			@users = User.all
		else
			redirect_to "/"
		end
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
		@user.level = 3
    	if @user.save
    		flash[:notice] = "Vous vous êtes bien inscrit"
        	flash[:color]= "valid"
			session[:user_id] = @user.id
			redirect_to "/users/#{@user.id}/edit"
     	else
        	flash[:notice] = "Le formulaire est invalide"
        	flash[:color]= "invalid"
			render 'new'
     	end
	end

	def show
		@user = User.find(params[:id])
		if @user.level == 0
			@levelLit = "Administrateur"
		elsif @user.level == 1
			@levelLit = "Modérateur"
		elsif @user.level == 2
			@leveLit = "Contributeur"
		elsif @user.level == 3
			@leveLit = "Utilisateur"
		end

		@totalmoney = 0
		@totalxp = 0
		@user.characters.each do |character|
			@totalmoney += character.money
			@totalxp += character.experience_points
		end
	end

	def edit
		if session[:user_id]
			@user = User.find(params[:id])
			@user_session = User.find(session[:user_id])
			if @user.id != @user_session.id && @user_session.level != 0
				redirect_to "/users/#{params[:id]}"
			end
		else
			redirect_to "/users/#{params[:id]}"
		end
	end

	def update
		@user = User.find(params[:id])
		@user.mail = params[:user][:mail]
		@user.last_name =params[:user][:last_name]
		@user.first_name =params[:user][:first_name]
		@user.level =params[:user][:level]
		@user.password = params[:user][:password]
		if @user.save
    		flash[:notice] = "Vous avez bien modifié votre compte"
        	flash[:color]= "valid"
			redirect_to "/users/#{@user.id}/edit"
     	else
        	flash[:notice] = "Le formulaire est invalide"
        	flash[:color]= "invalid"
			render "/users/#{@user.id}/edit"
     	end
	end

	def destroy
		if User.find(params[:id]).destroy
			flash[:notice] = "L'Utilisteur a bien été supprimé"
			flash[:color]= "valid"
			if session[:user_id] == params[:id]
				logout
			else
				redirect_to "/users"
			end
		else
        	flash[:notice] = "Il y a eu une erreur lors de la suppression de l'utilisateur"
        	flash[:color]= "invalid"
			render "/users/#{@user.id}/edit"
     	end
	end

	def check
		@current_user = User.where(username: params[:username]).first
		if @current_user
			encrypted_password = BCrypt::Engine.hash_secret(params[:password], @current_user.salt)
			if @current_user.encrypted_password == encrypted_password
				session[:user_id] = @current_user.id
				flash[:notice] = "Bienvenue #{@current_user.username} !"
				redirect_to "/users/#{@current_user.id}/edit"
			else
				flash[:notice] = "Connexion impossible : Mot de Passe incorrect."
				redirect_to "/"
			end
		else
			flash[:notice] = "Connexion impossible : cet Utilisateur n'existe pas."
			redirect_to "/"
		end
	end

	def logout
		session[:user_id] = nil
	    flash[:notice] = "Vous êtes maintenant déconnecté."
		redirect_to "/"
	end
end
