class ApplicationController < ActionController::Base
	before_action :set_current_user#, except: [:logout]
	#skip_before_action :set_current_user, only: [:, :create]

	private

 	def set_current_user
    	if session[:user_id]
    		@current_user = User.find(session[:user_id])
			# session[:user_id] = nil
    	end
	#session[:user_id]
	#@current_user = nil
	end
end
