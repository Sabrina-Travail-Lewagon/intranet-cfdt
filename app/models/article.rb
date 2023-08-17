class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  has_many :comments
  has_many :article_tags
  has_many :tags, through: :article_tags
end
