FactoryBot.define do
  factory :order_address do
    postcode           {'123-4567'}
    prefecture_id      {2}
    city               {'東京'}
    block              {'大阪市'}
    phone_number       {12345678901}
    token              {"tok_abcdefghijk00000000000000000"}
  end
end
