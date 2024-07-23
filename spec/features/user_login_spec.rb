require 'rails_helper'

RSpec.describe "UserLogins", type: :request do
  let(:user) { create(:user) }

 
    scenario 'ログイン後ユーザー情報、記録するリンク、ログアウトリンクがあるかを確認' do
      visit studytimes_path
      click_link 'ログイン画面へ', href:"/users/sign_in"
      fill_in "session_name", with: 'morita', fill_options: { clear: :backspace }
      fill_in "session_password", with: 'morita0823', fill_options: { clear: :backspace }
      expect(find_field('session_name').value).to eq 'morita'
      expect(page).to have_field('session_password', with: 'morita0823')
      click_button "ログイン"
      
      
    end
end
