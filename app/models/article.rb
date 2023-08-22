class Article < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  has_many :article_categories
  has_many :categories, through: :article_categories, dependent: :destroy
  # has_many :categories, through: :article_categories
  has_many :comments
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many_attached :images, service: :cloudinary
  has_rich_text :rich_body
end
