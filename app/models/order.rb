class Order < ApplicationRecord

  attr_accessor :token

  # Association
  has_one :address
  belongs_to :user
  belongs_to :item
  # Association (ActiveHash)
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end