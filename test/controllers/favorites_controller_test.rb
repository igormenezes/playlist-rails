require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
  	ActiveRecord::Base.connection.execute("TRUNCATE favorites RESTART IDENTITY CASCADE")
  	ActiveRecord::Base.connection.execute("TRUNCATE users RESTART IDENTITY CASCADE")
  	ActiveRecord::Base.connection.execute("TRUNCATE musics RESTART IDENTITY CASCADE")

  	user = User.new(name:'Teste', password: BCrypt::Password.create('123'), email: 'teste@yahoo.com.br', age: 25, administrator: 0)
	user.save

	post '/login', params: {
		user: { 
	  		email: 'teste@yahoo.com.br',
	  		password: '123'
	  	} 
	}
  end

  test "access favorites" do 
  	get '/list'
	assert_response :success
  end

  test "add favorite" do
  	music = Music.new(name:'One', style: 'Rock', artist: 'Metallica')
	music.save

	get "/add/#{session[:login]}"
	assert_redirected_to :list
  end

  test "remove favorite" do 
  	music = Music.new(name:'One', style: 'Rock', artist: 'Metallica')
	music.save

	get "/remove/#{session[:login]}"
	assert_redirected_to :favorites
  end

  test "list favorites" do
	get '/favorites'
	assert_response :success
  end

  test 'find musics success' do
	music = Music.new(name:'One', style: 'Rock', artist: 'Metallica')
	music.save

	post '/find', params: {
		music: {
			name: 'Rock'
		} 
	}

	assert_response :success
  end

  test 'find musics failed' do
	post '/find', params: {
		music: {
			name: 'Rock'
		} 
	}

	assert_equal 'Não foi encontrado nenhum Artista ou Estilo, de acordo com sua busca.', flash[:warning]
  end

  test 'logout' do
  	get '/quit'
  	assert_redirected_to root_url
  end

  teardown do
  end

end
