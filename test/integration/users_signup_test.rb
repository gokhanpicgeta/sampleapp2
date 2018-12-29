require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup info" do 
  	get signup_path
  	assert_no_difference 'User.count' do 
  		post signup_path, params: {user: { name: " ",
  										  email: "user@invalid",
  										  password: "foo",
  										  password_confirmation: "bar"} }
  	end
  	assert_template 'users/new'
  	assert_select 'div#error_explanation'
  	assert_select 'div.alert.alert-danger'
  	assert_select "li", "Name can't be blank"
  	assert_select "li", "Email is invalid"
  	assert_select "li", "Password confirmation doesn't match Password"
  	minimum_length = 0
  	min_validation = User.validators_on(:password).each do |x|
  		if x.options.key?(:minimum) 
  			minimum_length = x.options[:minimum]
  		else
  			#puts("Minimum length for password not found")
	 	end 
	end
  	assert_select "li", "Password is too short (minimum is #{minimum_length} characters)"
  	assert_select 'form[action = "/signup"]'

  end

  test "valid signup info" do 
  	get signup_path
  	assert_difference 'User.count', 1 do 
  		post signup_path, params: {user: { name: "Example User",
  										   email: "ExampleUser@validaddress.com",
  										   password: "foobar",
  										   password_confirmation: "foobar" }}
  	end 
  	follow_redirect!
  	assert_template 'users/show'
  	assert_not flash.empty?
  end 
end
