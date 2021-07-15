class Item < ApplicationRecord

  # Validation
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price, numericality: {only_integer: true, message: 'is invalid. Input half-width characters'}
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :genre_id
      validates :status_id
      validates :shipping_day_id
      validates :delivery_charge_id
      validates :prefecture_id
    end
  end
    validates :price, numericality: {greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

  # Association
  has_one_attached :image
  belongs_to :user
  # has_one :order

  # Association (ActiveHash)
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day

end