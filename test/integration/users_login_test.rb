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

test "login with valid information followed by logout" do
	user = users(:michael)
	get login_path
	assert_template 'session/new'
	post login_path, params: {session: {email:user.email, password:"password"}}
	follow_redirect!
	assert_template 'users/show'
	assert_select "a[href=?]", login_path, count: 0
	assert_select "a[href=?]", logout_path
	assert_select "a[href=?]", user_path(user)

	# logout
	delete logout_path
	assert_not is_logged_in?
	assert_redirected_to root_url

	#simulating logout in a second window
	delete logout_path
	
	follow_redirect!
	assert_select "a[href=?]", login_path
	assert_select "a[href=?]", logout_path, count: 0
	assert_select "a[href=?]", user_path(user), count: 0


end



test "login with remember" do
	user = users(:michael)
	log_in_as(user, remember_me: '1')
	assert_not_empty cookies['remember_token']
end


test "login without remember" do
	user = users(:michael)
	log_in_as(user, remember_me: '1')
	log_in_as(user, remember_me: '0')
	assert_empty cookies['remember_token'] 
end




end
























