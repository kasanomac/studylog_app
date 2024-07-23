require 'rails_helper'

describe User do
  describe '#create' do

      # 入力されている場合のテスト ▼

      it "全ての項目の入力が存在すれば登録できること" do
        user = build(:user)
        expect(user).to be_valid
      end

      # nul:false, presence: true のテスト ▼

      it "nameがない場合は登録できないこと" do 
        user = build(:user, name: nil) # 変数userにbuildメソッドを使用して、factory_botのダミーデータを代入
        user.valid? #バリデーションメソッドを使用して「バリデーションにより保存ができない状態であるか」をテスト
        expect(user.errors[:name]).to include("を入力してください") 
      end

      it "emailがない場合は登録できないこと" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "passwordがない場合は登録できないこと" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "password_confirmationがない場合は登録できないこと" do
        user = build(:user, password_confirmation: nil)
        user.valid?
        expect(user.errors[:password_confirmation]).to include("を入力してください")
      end

      it "重複したemailが存在する場合登録できないこと" do
        user = create(:user) # createメソッドを使用して変数userとデータベースにfactory_botのダミーデータを保存
        another_user = build(:user, email: user.email) # 2人目のanother_userを変数として作成し、buildメソッドを使用して、意図的にemailの内容を重複させる
        another_user.valid? # another_userの「バリデーションにより保存ができない状態であるか」をテスト
        expect(another_user.errors[:email]).to include("はすでに存在します") # errorsメソッドを使用して、emailの「バリデーションにより保存ができない状態である場合なぜできないのか」を確認し、その原因のエラー文を記述
      end

      it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
        user = build(:user, password_confirmation: "") # 意図的に確認用パスワードに値を空にする
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません", "を入力してください")
      end

      it "passwordが6文字以上であれば登録できること" do
        user = build(:user, password: "123456", password_confirmation: "123456") # buildメソッドを使用して6文字のパスワードを設定
        expect(user).to be_valid
      end

      it "passwordが5文字以下であれば登録できないこと" do
        user = build(:user, password: "12345", password_confirmation: "12345") # 意図的に5文字のパスワードを設定してエラーが出るかをテスト 
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      
  end
end
