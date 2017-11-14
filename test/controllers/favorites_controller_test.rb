require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
  	ActiveRecord::Base.connection.execute("TRUNCATE favorites RESTART IDENTITY CASCADE")
  end

  teardown do
  end

end
