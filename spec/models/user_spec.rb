require 'rails_helper'
describe User do
	describe '#create' do
		#全ての条件が整っている場合に登録ができること be_validマッチャ
		it "is valid with a nickname,email,password,password_confirmation" do
			user = build(:user)
			expect(user).to be_valid
		end

		#nicknameが空では登録できないこと
		it "is invalid without a nickname" do
			user = build(:user, nickname: "")
			user.valid?
			expect(user.errors[:nickname]).to include("can't be blank")
		end
		#emailが空では登録できないこと
		it "is invalid without a email" do
			user = build(:user, email: "")
			user.valid?
			expect(user.errors[:email]).to include("can't be blank")
		end

		#passwordが空では登録できないこと
		it "is invalid without a password" do
			user = build(:user, password: "")
			user.valid?
			expect(user.errors[:password]).to include("cna't be blank")
		end
		#passwordが存在してもpassword_confirmationが空では登録できないこと
		it "is invalid without a password_confirmation although with a password" do
            user = build(:user, password_confirmation: "")
            user.valid?
            expect(user.errors[:password_confirmation]).to include("doesn't match Password")
        end
		#nicknameが７文字以上であれば登録できないこと "nickname is too long"
		it "is invalid with a nickname that has more than 7characters" do
			user = build(:user, nickname: "aaaaaaaa")	
			user.valid?
			expect(user.errors[:nickname][0]).to include("is too long")
		end
		#nicknameが６文字以下では登録できること
		it "is valid with a nickname that has less than 6 characters" do
			user = build(:user, nickname: "aaaaaa")
			expect(user).to be_valid
		end
		#重複したemailが存在する場合登録できないこと
		it "is invalid with a duplicate email address" do
			#はじめにユーザーを登録
			user = create(:user)
			#先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
			another_user = build(:user)
			another_user.valid?
			expect(another_user.errors[:email]).to include("has already been taken")
		end
		#passwordが６文字以上であれば登録できること
		it "is invalid with a password that has more 6 characters" do
			user = build(:user)
			user.valid?
			expect(user).to be_valid
		end
		#passwordが５文字以下であれば登録できないこと "password is too short"
		it "is invalid witout a password that has less than 5 characters" do
			user = build(:user,password: "00000",password_confirmation: "00000")
			user.valid?
			expect(user.errors[:password][0]).to include("is too short")
		end
	end
end
