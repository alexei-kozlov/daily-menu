class ApplicationController < ActionController::Base
	http_basic_authenticate_with name: "admin", password: "qwerty"

	before_action :set_theme

	def set_theme
		if params[:theme].present?
			theme = params[:theme].to_sym
			# session[:theme] = theme
			cookies[:theme] = theme
			redirect_to(request.referrer || home_path)
		end
	end
end
