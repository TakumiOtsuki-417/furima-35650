require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録機能' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '登録が上手くいく場合' do
      it '全てのカラムを正しく記入すれば登録できること' do
        expect(@user).to be_valid
      end
      it 'パスワードは、6文字以上が入力されてかつ半角英数字が混合されており、かつ確認用パスワードと同等の入力であれば登録が可能なこと' do
        @user.password = 'a1b2c3'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'ユーザー本名（名字）は、全角（漢字）での入力の場合登録は可能なこと' do
        @user.last_name = '漢字'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（名前）は、全角（漢字）での入力の場合登録は可能なこと' do
        @user.first_name = '漢字'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（名字）は、全角（ひらがな）での入力の場合登録は可能なこと' do
        @user.last_name = 'ひらがな'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（名前）は、全角（ひらがな）での入力の場合登録は可能なこと' do
        @user.first_name = 'ひらがな'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（名字）は、全角（カタカナ）での入力の場合登録は可能なこと' do
        @user.last_name = 'カタカナ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（名前）は、全角（カタカナ）での入力の場合登録は可能なこと' do
        @user.first_name = 'カタカナ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナ（名字）は、全角（カタカナ）での入力であれば登録が可能なこと' do
        @user.last_name_kana = 'カタカナ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナ（名前）は、全角（カタカナ）での入力であれば登録が可能なこと' do
        @user.first_name_kana = 'カタカナ'
        expect(@user).to be_valid
      end
    end

    context '登録が上手くいかない場合' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        another_user = FactoryBot.create(:user)
        @user.email = another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'a1b2c'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは、半角アルファベットの入力だけでは登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers.')
      end
      it 'パスワードは、半角数字の入力だけでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers.')
      end
      it 'パスワードは、全角文字列の入力では登録できないこと' do
        @user.password = 'ａ１ｂ２ｃ３'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers.')
      end
      it 'パスワード（確認用）が必須であること（パスワードは２回記入する必要があること）' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password = 'a1b2c3'
        @user.password_confirmation = 'a1b2c4'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'ユーザー本名は、名字が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'ユーザー本名は、名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名（名字）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名（名前）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名のフリガナ（名字）は、名字が必須であること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名のフリガナ（名前）は、名前がそれぞれ必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'ユーザー本名のフリガナ（名字）は、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'ｶﾀｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名のフリガナ（名前）は、全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'ｶﾀｶﾅ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
      end
      it '生年月日が必須であること' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end
