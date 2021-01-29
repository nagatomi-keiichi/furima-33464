# テーブル設計 


## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| encrypted_password        | string | null: false |
| first_name      | string | null: false |
| last_name       | string | null: false |
| first_name_kana | string | null: false |
| last_name_kana  | string | null: false |
| birthday_id     | date null: false |

### Association

- has_many :address, 
- has_many :items

## items テーブル

| Column       | Type     | Options     |
| ------------ | ------   | ----------- |
| item_name    | string   | null: false |
| information  | text     | null: false |
| category_id  | integer  | null: false |
| state_id     | integer  | null: false |
| burden_id    | integer  | null: false |
| area_id      | integer  | null: false |
| days_id      | integer  | null: false |
| price        | integer  | null: false |
| user         | references|  null: false, foreign_key: true |
### Association

- has_one   :order
- belongs   :user
## orders テーブル
| Colum   | Type  |Option      |
| ------- | ----- | -----------|
| user      | references |  null: false, foreign_key: true |
| item      | references |  null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :address
## address テーブル

| Column       | Type   | Options    |      
| -------------|--------|------------|
| postcode     | string | null false |
| prefectures_id  | integer | null false |
| city         | string | null false |
| block        | string | null false |
| building     | string |             |
| phone_number | integer | null false |
| order        | references |  null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :order

