class UsersController < ApplicationController
	def index
		flash.delete(:warning)

		if session[:login] && session[:administrator] == 1
			redirect_to	:music
		elsif session[:login] && session[:administrator] == 0
			redirect_to :list
		end
	end

	def register
		flash.delete(:warning)
	end

	def login
		values = params.require(:user).permit :email, :password

		if values['email'].empty? || values['password'].empty?
			flash[:warning] = "Por favor, insira seu Email e Password!"
	    	return render :index	
		end

		user = User.select(:id, :email, :password, :administrator).where('email = ?', values['email']).first

		if user && BCrypt::Password.new(user['password']) == values['password']
			session[:login] = user['id']

			if user['administrator'] == 1
				session[:administrator] = 1
				redirect_to :music
			else
				session[:administrator] = 0
				redirect_to :list
			end
		else
			flash[:warning] = "E-mail e/ou Password incorreto!"
			return render :index
		end
	end

	def create  
		begin
    		values = params.require(:user).permit :name, :password, :email, :age, :administrator
    		values['password'] = BCrypt::Password.create params[:user]['password']	

	    	user_registered = User.where('email = ?', params[:user][:email])
		
	    	if !user_registered.empty?
	    		flash[:warning] = 'E-mail já cadastrado!'
	    		return render :register
	    	end

	    	user_existed = User.limit(1)

	    	if user_existed.empty?
	    		values['administrator'] = params[:user][:adminsitrator] = 1
	    	end

	    	@user = User.new values

	    	if @user.save
	    		redirect_to root_url
	    	end
  		rescue => e
    		flash[:warning] = "Ocorreu um erro, ao tentar cadastrar o usuário! Erro: #{e}"
	    	return render :register
  		end
	end
end
