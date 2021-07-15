require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品投稿機能' do
    before do
      @item = FactoryBot.build(:item)
    end
    context '登録が上手くいく場合' do
      
      it '全ての情報を正しく入力したら登録できること' do
        expect(@item).to be_valid
      end
      it '販売価格は最低300円からの入力であること' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it '販売価格は最高9999999円までの入力であること' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
      it '販売価格は半角数字の入力で登録できること' do
        @item.price = 1234
        expect(@item).to be_valid
      end
      it 'カテゴリーはどれか選択されている(1:「---」以外)場合保存できること' do
        @item.genre_id = 2
        expect(@item).to be_valid
      end
      it '商品の状態はどれか選択されている(1:「---」以外)場合保存できることと' do
        @item.status_id = 2
        expect(@item).to be_valid
      end
      it '配送料の負担はどれか選択されている(1:「---」以外)場合保存できること' do
        @item.delivery_charge_id = 2
        expect(@item).to be_valid
      end
      it '発送元の地域はどれか選択されている(1:「---」以外)場合保存できること' do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it '発送までの日数はどれか選択されている(1:「---」以外)場合保存できること' do
        @item.shipping_day_id = 2
        expect(@item).to be_valid
      end
    end
    context '登録に失敗する場合' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が必須であること' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が必須であること' do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報が必須であること' do
        @item.genre_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Genre can't be blank")
      end
      it 'カテゴリーが未選択(「---」)のままだと保存できないこと' do
        @item.genre_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Genre can't be blank")
      end
      it '商品の状態についての情報が必須であること' do
        @item.status_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it '商品の状態が未選択(「---」)のままだと保存できないこと' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it '配送料の負担についての情報が必須であること' do
        @item.delivery_charge_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end
      it '配送料の負担が未選択(「---」)のままだと保存できないこと' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end
      it '発送元の地域についての情報が必須であること' do
        @item.prefecture_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送元の地域が未選択(「---」)のままだと保存できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数についての情報が必須であること' do
        @item.shipping_day_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it '発送までの日数が未選択(「---」)のままだと保存できないこと' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it '販売価格についての情報が必須であること' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格は、¥300未満では保存できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it '販売価格は、¥9999999を超えると保存できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it '販売価格は全角数字では保存できないこと' do
        @item.price = "３００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it '販売価格は全角の文字列では保存できないこと' do
        @item.price = "三百"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it '販売価格は半角の文字列では保存できないこと' do
        @item.price = "abcde"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it '販売価格は半角英数混合では保存できないこと' do
        @item.price = "ab300"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
    end
  end
end
