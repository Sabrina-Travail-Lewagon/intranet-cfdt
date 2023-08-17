class Category < ApplicationRecord
  validates :nom, presence: true
  has_many :article_categories
  has_many :articles, through: :article_categories
end
