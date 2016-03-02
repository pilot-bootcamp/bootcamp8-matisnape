def sign_in(email, password)
  visit new_session_path
  fill_in "Email:", with: email
  fill_in "Password:", with: password
  click_button "Sign in"
end

