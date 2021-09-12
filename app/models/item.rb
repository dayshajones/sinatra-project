class Item < ActiveRecord::Base
    belongs_to :user
    validates :name, presence: :true
    validates :quantity, presence: :true
    validates :user_id, presence: :true
end
