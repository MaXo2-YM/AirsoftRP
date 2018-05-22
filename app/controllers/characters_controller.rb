class CharactersController < ApplicationController
    def create
        character = Character.new
        character.last_name = params[:last_name]
        character.first_name = params[:first_name]
        character.age = params[:age]
        character.sex = params[:sex]
        character.background = params[:background]
        character.experience_points = 1000
        character.money = 500 + rand(501)
        character.user_id = params[:user_id]
        character.save!

		redirect_to "/characters/1"
	end

    def show
        @character = Character.find(params[:id])
    end

    def update
		Character.find(params[:id]).update background: params[:background]
		redirect_to "/characters/#{params[:id]}"
	end

    def destroy
		user = Character.find(params[:id]).user_id
        Character.find(params[:id]).destroy
		redirect_to "/users/#{user}"
	end
end
