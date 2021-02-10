class OrderAddress 
include ActiveModel::Model
attr_accessor :postcode,:prefecture_id,:city,:block,:building,:phone_number,:user_id,:item_id

with_options presence: true do
  validates :postcode, format: { with:/\A[0-9]{3}-[0-9]{4}\z/}
  validates :city  #市町村
  validates :phone_number, format: { with:/\A\d{10,11}\z/}
  validates :block  #番地
end
validates :prefecture_id, numericality: { other_than: 1 }

def save
  order = Order.create(user_id:user.id,item_id:item.id)
  Address.create(postcode:postcode,prefecture_id:prefecture.id,city:city,block:block,building:building,phone_number:phone_number)
end
end