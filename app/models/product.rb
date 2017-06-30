class Product < ActiveRecord::Base
  validates :name, :cost, :origin, :brand, :presence => true
  has_many :reviews

  scope :newest_products, -> { order(created_at: :desc).limit(3)}

  scope :most_reviews, -> {(
    select("products.name, products.id, products.created_at, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .limit(3)
    )}


  # scope :style, -> (style_param) { where(style: style_param) }
end
