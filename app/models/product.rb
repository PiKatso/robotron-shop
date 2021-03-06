class Product < ActiveRecord::Base
  validates :name, :origin, :brand, :url, :presence => true
  validates :cost, numericality: true, :presence => true
  has_many :reviews, dependent: :destroy


  scope :newest_products, -> { order(created_at: :desc).limit(3)}

  scope :most_reviews, -> {(
    select("products.name, products.url, products.id, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .limit(3)
    )}

  scope :locally_made, -> { where(origin: "USA") }

  # scope :style, -> (style_param) { where(style: style_param) }
end
