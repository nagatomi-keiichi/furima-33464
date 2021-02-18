require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができる場合' do
      it 'nameとemail、passwordとpassword_confirmation、first_name、last_name、first_name_kana、last_name_kana、birthday_idが存在すれば登録できること' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録ができない場合' do
      it 'nameが空では登録できないこと' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'emailが＠を含めない場合は登録できないこと' do
        @user.email = 'aaaabbbb'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end

      it 'passwordが空では登録できないこと' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは不正な値です", "パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'passwordが5文字以下であれば登録できないこと' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください", "パスワードは不正な値です")
      end

      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは不正な値です")
      end
      it 'passwordが半角英語のみでは登録できない事' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが半角数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが全角英数混合では登録できないこと' do
        @user.password = 'Aa１123456'
        @user.password_confirmation = 'Aa１123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        anoteher_user = FactoryBot.build(:user, email: @user.email)
        anoteher_user.valid?
        expect(anoteher_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'first_nameは必須であること' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First nameを入力してください", "First nameは不正な値です")
      end
      it 'last_nameは必須であること' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last nameを入力してください", "Last nameは不正な値です")
      end
      it 'first_name_kanaは必須であること' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanaを入力してください", "First name kanaは不正な値です")
      end
      it 'last_name_kanaは必須であること' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanaを入力してください", "Last name kanaは不正な値です")
      end
      it 'first_nameは漢字・平仮名・カタカナ以外では登録できないこと' do
        @user.first_name = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("First nameは不正な値です")
      end
      it 'last_nameは漢字・平仮名・カタカナ以外では登録できないこと' do
        @user.last_name = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last nameは不正な値です')
      end
      it 'first_name_kanaは全角カタカナ以外では登録できないこと' do
        @user.first_name_kana = 'ｱｱああアア'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanaは不正な値です')
      end
      it 'last_name_kanaは全角カタカナ以外では登録できないこと' do
        @user.last_name_kana = 'ｱｱああアア'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kanaは不正な値です')
      end
      it '生年月日がからでは登録できないこと' do
        @user.birthday_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdayを入力してください")
      end
    end
  end
end
