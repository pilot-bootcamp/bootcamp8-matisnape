def sign_in(email, password)
  visit login_path
  fill_in t('user.form.email'), with: email
  fill_in t('user.form.password'), with: password
  click_button t('user.sign_in')
end

