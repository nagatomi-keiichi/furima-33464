require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
end

describe '商品購入ができる場合' do
  context '商品が購入できる場合' do
    it '郵便番号・都道府県・市区町村・電話番号があれば購入できる' do
    end
  end

  context '商品購入ができない場合' do
    it '郵便番号の入力が必須であること' do
      @order_address.postcode = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
    end
    it '郵便番号の入力にはハイフンが必須であること' do
      @order_address.postcode = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postcode is invalid")
    end

      it '都道府県の入力が必須であること' do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture is not a number")
      end
      it '都道府県は１が選択された場合は購入できない事' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '市区町村の入力が必須であること' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地の入力が必須であること' do
        @order_address.block = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号の入力が必須であること' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank", "Phone number is invalid")
      end
      it '電話番号の入力が11桁以内であること' do
        @order_address.phone_number = '09012345'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
  end
end
end
