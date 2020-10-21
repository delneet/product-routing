class Product < ApplicationRecord
    validates :reference, uniqueness: true
    validates :name, presence: true, uniqueness: {scope: :category}
    validates :category, presence: true
    validates :price, numericality: true
end
