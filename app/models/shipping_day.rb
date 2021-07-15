class ShippingDay < ActiveHash::Base
  #発送にかかる日数の選択肢を定義します
  self.data = [
    {id: 1, name: '--'},
    {id: 2, name: '1~2日で発送'},
    {id: 3, name: '2~3日で発送'},
    {id: 4, name: '6~7日で発送'}
  ]
  include ActiveHash::Associations
  has_many :items
  end