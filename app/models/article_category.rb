class ArticleCategory < ApplicationRecord
  belongs_to :article, on_delete: :cascade
  belongs_to :category
end
