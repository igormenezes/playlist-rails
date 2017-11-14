require 'test_helper'

class MusicsControllerTest < ActionDispatch::IntegrationTest
  setup do
  	ActiveRecord::Base.connection.execute("TRUNCATE musics RESTART IDENTITY CASCADE")
  end

  test "access panel musics authorized" do
  	user = User.new(name:'Teste', password: BCrypt::Password.create('123'), email: 'teste@yahoo.com.br', age: 25, administrator: 1)
  	user.save

  	post '/login', params: {
  		user: { 
  			email: 'teste@yahoo.com.br',
  			password: '123'
  		} 
	  }

  	get '/music'
    assert_response :success
  end

  test "access panel musics denied" do
  	user = User.new(name:'Teste', password: BCrypt::Password.create('123'), email: 'teste@yahoo.com.br', age: 25, administrator: 0)
  	user.save

    post '/login', params: {
  		user: { 
  			email: 'teste@yahoo.com.br',
  			password: '123'
  		} 
	  }

  	get '/music'
    assert_redirected_to root_url
  end

  test "save new music" do
  	post '/save', params: {
		music: { 
			name: 'One',
			style: 'Rock',
			artist: 'Metallica'
		} 
	}

	assert_equal 'Música cadastrada com sucesso!', flash[:notice]
  end

  test "save existed music" do
  	user = Music.new(name:'One', style: 'Rock', artist: 'Metallica')
	user.save

  	post '/save', params: {
		music: { 
			name: 'One',
			style: 'Rock',
			artist: 'Metallica'
		} 
	}

	assert_equal 'Essa música já foi cadastrada!', flash[:warning]
  end  

  test "exit musics" do
  	get '/exit'
  	assert_redirected_to root_url
  end

  test "access rank" do
    user = User.new(name:'Teste', password: BCrypt::Password.create('123'), email: 'teste@yahoo.com.br', age: 25, administrator: 1)
    user.save

    post '/login', params: {
      user: { 
        email: 'teste@yahoo.com.br',
        password: '123'
      } 
    }

    get '/rank'
    assert_response :success
  end

  teardown do
  end

end
