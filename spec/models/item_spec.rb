require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品するとき' do
    context 'ユーザー新規登録ができる場合' do
      it 'nameとinfomationとpriceとcategory_idとstate_idとburden_idとarea_idとday_idとuser_idとimageがあると保存できる' do
        expect(@item).to be_valid
      end
      it '価格の範囲が300~9999999￥なら登録できる' do
        @item.price = 500
        expect(@item).to be_valid
      end
    end
    context 'ユーザー新規登録ができない場合' do
      it '商品画像を1枚つける事が必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が必須であること' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が必須であること' do
        @item.infomation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Infomation can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not a number')
      end
      it '商品の状態についての情報が必須であること' do
        @item.state = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('State is not a number')
      end

      it '配送料の負担について情報が必須であること' do
        @item.burden_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Burden is not a number')
      end

      it '発送元の地域について情報が必須であること' do
        @item.area_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Area is not a number')
      end

      it '発送までの日数についての情報が必須であること' do
        @item.day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Day is not a number')
      end

      it '価格の範囲が、￥300以下では登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 299')
      end

      it '価格の範囲が、￥10000000以上では登録できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 10000000')
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
