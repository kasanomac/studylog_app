require 'rails_helper'

RSpec.describe "Pages", type: :system do
  let(:user) { FactoryBot.create(:user) }
  describe '#home' do
    it 'トップページにアクセス後、「ログイン画面へ」のリンクがあるかを確認' do
      visit studytimes_path
      expect(page.status_code).to eq(200)
      expect(page).to have_link 'ログイン画面へ', href:"/users/sign_in"
    end
  end

  describe '各アクションの確認' do
    scenario '新規登録後にindexへ遷移してユーザー情報、記録するリンク、ログアウトリンクがあるかを確認' do
      visit studytimes_path 
      login_as(user)
      expect(page).to have_content("tarouさん")
      expect(page).to have_links("記録する", "ログアウト")
      expect(page).to have_contents("今日の勉強時間：", "今までの勉強時間：")
    end
    it '入力していない箇所があればエラーを出すことを確認(新規登録)' do
      visit studytimes_path
      click_link 'ログイン画面へ', href:"/users/sign_in"
      click_link '新規登録はこちら', href:"/users/sign_up"
      fill_in "registraion_name", with: ''
      fill_in "registraion_email", with: ''
      fill_in "registraion_password", with: ''
      fill_in "registraion_password_confirmation", with: ''
      click_button "登録する"
      expect(page.status_code).to eq(422)
    end

    it '入力していない箇所があればエラーを出すことを確認(ログイン)' do
      visit studytimes_path
      click_link 'ログイン画面へ', href:"/users/sign_in"
      click_link '新規登録はこちら', href:"/users/sign_up"
      fill_in "registraion_name", with: 'tarou'
      fill_in "registraion_email", with: 'tarou@gmail.com'
      fill_in "registraion_password", with: 'tarouyade'
      fill_in "registraion_password_confirmation", with: 'tarouyade'
      click_button "登録する"
      click_link "ログアウト"
      fill_in "session_name", with: ''
      fill_in "session_password", with: ''
      click_button "session_login"
      expect(page.status_code).to eq(422)
    end

    it '同一のメールアドレスでは新規登録できないことを確認' do
      visit studytimes_path
      click_link 'ログイン画面へ', href:"/users/sign_in"
      click_link '新規登録はこちら', href:"/users/sign_up"
      fill_in "registraion_name", with: 'tarou'
      fill_in "registraion_email", with: 'tarou@gmail.com'
      fill_in "registraion_password", with: 'tarouyade'
      fill_in "registraion_password_confirmation", with: 'tarouyade'
      click_button "登録する"
      click_link "ログアウト"
      click_link '新規登録はこちら', href:"/users/sign_up"
      fill_in "registraion_name", with: 'tarou'
      fill_in "registraion_email", with: 'tarou@gmail.com'
      fill_in "registraion_password", with: 'tarouyade'
      fill_in "registraion_password_confirmation", with: 'tarouyade'
      click_button "登録する"
      expect(page).to have_content("メールアドレスはすでに存在します")
    end
    
    scenario 'CRUD処理の確認' do
      visit studytimes_path 
      login_as(user)

      #Createの確認
      click_link "記録する"
      expect{
      select '1', from: '時間'
      select '1', from: '分'
      fill_in "create_memo", with: "testyade"
      attach_file('create_image', Rails.root.join('spec/fixtures/files/test_family.jpeg'))
      click_button "登録する"}.to change(Studytime, :count).by(1)

      #Updateの確認
      click_link "編集"
      select '2', from: '時間'
      select '2', from: '分'
      fill_in "create_memo", with: "updatedsaretayannne"
      attach_file('create_image', Rails.root.join('spec/fixtures/files/updated_family.jpeg'))
      click_button '更新する'
      expect(page).to have_content("記録を更新しました")

      #destroyの確認
      visit studytimes_path
      click_link '詳細'
      expect{
      click_button '削除'}.to change(Studytime, :count).by(-1)
    end
  end
end
