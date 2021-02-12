require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    buyer = FactoryBot.create(:user)
    seller = FactoryBot.create(:user)
    item = FactoryBot.build(:item, user_id: seller.id)
    item.save
    sleep 0.5
    @order_address = FactoryBot.build(:order_address, user_id: buyer.id, item_id: item.id)
  end

  describe '商品購入ができる場合' do
    context '商品が購入できる場合' do
      it '郵便番号・都道府県・市区町村・電話番号・クレジット情報があれば購入できる' do
        expect(@order_address.valid?).to eq true
      end
      it '建物名が空でも登録できる' do
        @order_address.building = nil
        expect(@order_address).to be_valid
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
        expect(@order_address.errors.full_messages).to include('Postcode is invalid')
      end

      it '都道府県の入力が必須であること' do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture is not a number')
      end
      it '都道府県は１が選択された場合は購入できない事' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
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
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号の入力が11桁以内であること' do
        @order_address.phone_number = '09012345678910'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenがないと購入できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空では登録できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では登録できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
