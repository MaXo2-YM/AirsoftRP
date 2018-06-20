class UsersController < ApplicationController

	def index
		if @current_user.try(:admin?)
			@users = User.all
		else
			return redirect_to request.referrer || root_path
		end
	end

	def new
    	@user = User.new
	end

	def create
    	@user = User.new
		@user.username = params[:user][:username]
		@user.mail = params[:user][:mail]
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]
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
		if @user.admin?
			@levelLit = "Administrateur"
		elsif @user.role == 1
			@levelLit = "Modérateur"
		elsif @user.role == 2
			@leveLit = "Contributeur"
		elsif @user.role == 3
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
		if @current_user
			@user = User.find(params[:id])
			if @user.id != @current_user.id && !@current_user.admin?
				redirect_to request.referrer || "/users/#{params[:id]}"
			end
		else
			redirect_to request.referrer || "/users/#{params[:id]}"
		end
	end

	def update
		@user = User.find(params[:id])
		@user.mail = params[:user][:mail]
		@user.last_name = params[:user][:last_name]
		@user.first_name = params[:user][:first_name]
		@user.role = params[:user][:role]
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
			if @current_user.id == params[:id].to_i
				logout
			else
				redirect_to "/users"
			end
		else
        	flash[:notice] = "Il y a eu une erreur lors de la suppression de l'utilisateur"
        	flash[:color]= "invalid"
			render "/users/#{params[:id]}/edit"
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
				redirect_to root_path
			end
		else
			flash[:notice] = "Connexion impossible : cet Utilisateur n'existe pas."
			redirect_to root_path
		end
	end

	def logout
		session[:user_id] = nil
		@current_user = nil
	    flash[:notice] = "Vous êtes maintenant déconnecté."
		redirect_to root_path
	end
end
