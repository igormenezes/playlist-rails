class FavoritesController < ApplicationController
	def index
		if !session[:login] && !session[:administrator]
			redirect_to root_url
		end

		@musics = Music.select('musics.*').joins('LEFT JOIN favorites ON musics.id = favorites.musics_id').where('
			(favorites.users_id IS NULL OR favorites.users_id <> ?) AND musics.name NOT IN (?)', session[:login], Favorite.select(:name).where('users_id = ?', session[:login]))

 		return render :index
 	end

 	def add
 		begin
	 		if !session[:login] || !params[:id]
				redirect_to '/list'
			end

			music = Music.where('id = ?', params[:id].to_i).first
			favorites = Favorite.new(:users_id => session[:login], :musics_id => music.id, :name => music.name, :style => music.style, :artist => music.artist)
			
			if favorites.save
				redirect_to '/list'
			end
		rescue => e
			@musics = '' 
    		flash[:warning] = "Ocorreu um erro, ao tentar adicionar música aos favoritos! Erro: #{e}"
	    	return render :index				
		end
 	end

 	def remove
 		begin
	 		if !session[:login] || !params[:id]
					redirect_to '/list'
			end

			if Favorite.delete(params[:id].to_i)
				redirect_to '/favorites'
			end
		rescue => e
			@favorites = ''
			flash[:warning] = "Ocorreu um erro, ao tentar adicionar música aos favoritos! Erro: #{e}"
	    	return render :favorites	
		end
 	end

 	def favorites
 		if !session[:login] && !session[:administrator]
 			redirect_to root_url
 		end

 		@favorites = Favorite.where('users_id = ?', session[:login])
 		return render :favorites
 	end

	def quit
  		reset_session
  		redirect_to root_url
  	end
end
