require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  
  describe '商品購入機能' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
      sleep 0.05
    end

    context '購入手続きが成功する場合' do
      
      it '全て正しく入力すると保存できること' do
        expect(@order_address).to be_valid
      end
      it '建物名は空でも入力に成功すること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
      it '電話番号は11桁以内の数値であれば保存できること' do
        @order_address.phone_number = '01234567890'
        expect(@order_address).to be_valid
      end
      it '郵便番号は3文字の半角数字＋ハイフン＋４文字の半角数字の組み合わせであれば保存できること' do
        @order_address.postal_code = '012-3456'
        expect(@order_address).to be_valid
      end
      
    end

    context '購入手続きが失敗する場合' do      

      it 'クレジットカードを正しく入力しないと保存できないこと（tokenが必須であること）' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it '配送先の情報として、郵便番号が必須であること' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号の保存にはハイフンが必要であること（123-4567としなければ通らない）' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号の保存にはハイフンが必要であること（2文字-5文字は通らない）' do
        @order_address.postal_code = '12-34567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号の保存にはハイフンが必要であること（4文字-3文字は通らない）' do
        @order_address.postal_code = '1234-567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号は半角英数混合では保存できないこと' do
        @order_address.postal_code = '1b3-d5f7'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号は全角半角混合では保存できないこと' do
        @order_address.postal_code = '１2３-４5６7'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '配送先の情報として、都道府県が必須であること' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が未選択（「---」）のままだと保存できないこと' do
        @order_address.prefecture_id = 1        
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '配送先の情報として、市区町村が必須であること' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '配送先の情報として、番地が必須であること' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it '配送先の情報として、電話番号が必須であること' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号は11桁を超えた数値では保存できないこと' do
        @order_address.phone_number = '012345678901'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too long")
      end
      it '電話番号は10桁未満の数値では保存できないこと' do
        @order_address.phone_number = '012345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too short")
      end
      it '電話番号は文字列では保存できないこと' do
        @order_address.phone_number = 'abcdefghij'        
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only half-number")
      end
      it '電話番号は全角数字では保存できないこと' do
        @order_address.phone_number = '１２３４５６７８９０'        
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only half-number")
      end
      it '電話番号は全角半角混合では保存できないこと' do
        @order_address.phone_number = '１2３4５6７8９0'        
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only half-number")
      end
      it '電話番号はハイフンを入れて保存できないこと' do
        @order_address.phone_number = '01-234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only half-number")
      end
      it 'ユーザー情報と紐付けられないと保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it '商品情報と紐付けられないと保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

    end

  end

end
