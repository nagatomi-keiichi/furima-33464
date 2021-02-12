class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_one    :order
  belongs_to :user
  belongs_to :area
  belongs_to :burden
  belongs_to :category
  belongs_to :day
  belongs_to :state
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :infomation
    validates :price, format: { with: /\A[0-9]+\z/ }
    validates :image
  end

  validates :price, format: { with: /\A[0-9]+\z/ },
                    numericality: { greater_than: 299, less_than: 10_000_000 }

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :state_id
    validates :burden_id
    validates :area_id
    validates :day_id
  end
end
