# spec/support/authentication_helpers.rb

module AuthenticationHelpers
    def login_as(user)       #ログインしていない状態でindexを訪れると
        click_link 'ログイン画面へ', href:"/users/sign_in"
        click_link '新規登録はこちら', href:"/users/sign_up"
        fill_in "registraion_name", with: 'tarou'
        fill_in "registraion_email", with: 'tarou@gmail.com'
        fill_in "registraion_password", with: 'tarouyade'
        fill_in "registraion_password_confirmation", with: 'tarouyade'
        click_button "登録する"
        click_link "ログアウト"
        fill_in "session_name", with: 'tarou'
        fill_in "session_password", with: 'tarouyade'
        click_button "session_login" 
    end
  end
  