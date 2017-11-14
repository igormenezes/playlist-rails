class MusicsController < ApplicationController
	def index
		flash.delete(:warning)
		flash.delete(:notice)

		if !session[:login] || session[:administrator] != 1
			redirect_to root_url
		end
  	end

  	def save
  		begin
  			flash.delete(:notice)
  			flash.delete(:warning)
  			
	  		values = params.require(:music).permit :name, :style, :artist

	  		music_existed = Music.select(:id).where('name = ? AND style = ? AND artist = ?', 
	  			params[:music]['name'], params[:music]['style'], params[:music]['artist']).first

	  		if music_existed.nil?
	  			music = Music.new values
	  			music.save

	  			flash[:notice] = "Música cadastrada com sucesso!"
	  			return render :index
	  		else
	  			flash[:warning] = "Essa música já foi cadastrada!"
		    	return render :index
	  		end
	  	rescue => e
	  		flash[:warning] = "Ocorreu um erro, ao tentar cadastrar a música! Erro: #{e}"
	    	return render :index
  		end
  	end

  	def rank
  		if !session[:login] || session[:administrator] != 1
  			redirect_to root_url
  		end

 		@favorites = Favorite.select(:name, :style, :artist)
 		return render :rank
  	end

  	def search
  		puts 'teste'
  	end

	def exit
		reset_session
		redirect_to root_url
	end
end
