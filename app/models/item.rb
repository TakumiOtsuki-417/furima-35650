class Item < ApplicationRecord

  # Validation
  with_options presence: true do
    with_options numericality: { other_than: 1 } do
      validates :genre_id
      validates :status_id
      validates :shipping_day_id
      validates :delivery_charge_id
      validates :prefecture_id
    end
    validates :image
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }, format: { with: /\A[0-9]+\z/
, message: 'is invalid. Input half-width characters' }
  end
    validates :name
    validates :description
  end

  # Association
  has_one_attached :image
  belongs_to :user
  # has_one :order

  # Association (ActiveHash)
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :status
  belongs_to :genre
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day

end