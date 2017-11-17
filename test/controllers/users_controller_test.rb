require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	setup do
		ActiveRecord::Base.connection.execute("TRUNCATE users RESTART IDENTITY CASCADE")
	end

	test "access panel music" do
		user = User.new(name:'Teste', password: BCrypt::Password.create('123'), email: 'teste@yahoo.com.br', age: 25, administrator: 1)
		user.save

		post '/login', params: {
			user: { 
				email: 'teste@yahoo.com.br',
				password: '123'
			} 
		}

		get root_url
		assert_redirected_to :music
	end

	test "access panel list" do
		user = User.new(name:'Teste', password: BCrypt::Password.create('123'), email: 'teste@yahoo.com.br', age: 25, administrator: 0)
		user.save

		post '/login', params: {
			user: { 
				email: 'teste@yahoo.com.br',
				password: '123'
			} 
		}

		get root_url
		assert_redirected_to :list
	end

	test "create administrator user" do
		User.transaction do
			post '/create', params: {
				user: {
					name: 'Teste', 
					password: '123', 
					email: 'teste@yahoo.com.br', 
					age: 25, 
				} 
			}

			assert_redirected_to root_url
			raise ActiveRecord::Rollback
		end
	end

	test "create repeat user" do
		User.transaction do
			user = User.new(name:'Teste', password: BCrypt::Password.create('123'), email: 'teste2@yahoo.com.br', age: 25)
			user.save

			post '/create', params: {
				user: {
					name: 'Teste', 
					password: '123', 
					email: 'teste2@yahoo.com.br', 
					age: 25, 
				} 
			}

			assert_equal 'E-mail já cadastrado!', flash[:warning] 
			raise ActiveRecord::Rollback
		end
	end

	test "login with administrator user" do
		User.transaction do
			user = User.new(name:'Teste', password: BCrypt::Password.create('123'), email: 'teste@yahoo.com.br', age: 25, administrator: 1)
			user.save

			post '/login', params: {
				user: { 
					email: 'teste@yahoo.com.br',
					password: '123'
				} 
			}

			assert_redirected_to :music
			raise ActiveRecord::Rollback
		end	
	end

	test "login with common user" do
		User.transaction do
			user = User.new(name:'Teste', password: BCrypt::Password.create('123'), email: 'teste2@yahoo.com.br', age: 25, administrator: 0)
			user.save

			post '/login', params: {
				user: { 
					email: 'teste2@yahoo.com.br',
					password: '123'
				} 
			}

			assert_redirected_to :list
			raise ActiveRecord::Rollback
		end	
	end

	test "login with not exist user" do
		post '/login', params: {
			user: { 
				email: 'teste@yahoo.com.br',
				password: '123'
			} 
		}

		assert_equal 'E-mail e/ou Password incorreto!', flash[:warning] 
	end

	teardown do
	end
end
