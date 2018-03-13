require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

test "login with invalid information" do 
	get login_path
	assert_template 'session/new'
	post login_path, params: {session: {email:"aaa", password:"asfadf"}}
	assert_not flash.empty?
	get root_path
	assert flash.empty?


end

test "login with valid information" do
	user = users(:michael)
	get login_path
	assert_template 'session/new'
	post login_path, params: {session: {email:user.email, password:"password"}}
	follow_redirect!
	assert_template 'users/show'
	assert_select "a[href=?]", login_path, count: 0
	assert_select "a[href=?]", logout_path
	assert_select "a[href=?]", user_path(user)

end




end
