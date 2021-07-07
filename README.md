# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false |
| encrypted_password | string | null: false |
| nickname           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth              | string | null: false |


### Association

- has_many :items
- has_many :orders

## items テーブル

| Column             | Type       | Options                                      |
| ------------------ | ---------- | -------------------------------------------- |
| name               | string     | null: false                                  |
| description        | text       | null: false                                  |
| price              | integer    | null: false, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 } |
| genre_id           | integer    | null: false, numericality: { other_than: 1 } |
| status_id          | integer    | null: false, numericality: { other_than: 1 } |
| delivery_charge_id | integer    | null: false, numericality: { other_than: 1 } |
| from_place_id      | integer    | null: false, numericality: { other_than: 1 } |
| shipping_day_id    | integer    | null: false, numericality: { other_than: 1 } |
| user_id            | references | null: false, foreign_key: true               |

### Association

- belongs_to :user
- has_one :order

### Association (ActiveHash)

- belongs_to :genre
- belongs_to :status
- belongs_to :delivery_charge
- belongs_to :from_place
- belongs_to :shipping_day

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user_id   | references | null: false, foreign_key: true |
| item_id   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options                                                                              |
| ------------- | ---------- | ------------------------------------------------------------------------------------ |
| postal_code   | string     | null: false, numericality: { only_integer: true }, format: { with: /\A\d{7}\z/ }     |
| prefecture_id | integer    | null: false, numericality: { other_than: 1 }                                         |
| city          | string     | null: false                                                                          |
| house_number  | string     | null: false                                                                          |
| building_name | string     |                                                                                      |
| phone_number  | integer    | null: false, numericality: { only_integer: true }, format: { with: /\A\d{10,11}\z/ } |
| order_id      | references | null: false, foreign_key: true                                                       |

### Association

- belongs_to :order

### Association (ActiveHash)
- belongs_to :prefecture