class Book < ApplicationRecord
  paginates_per 12
 
  has_and_belongs_to_many :author
  belongs_to :category
  has_many :reviews
  has_many :order_items
  
  SORT_TYPES = [:newest, :popular, :price_hl, :price_lh, :title_asc, :title_desc]
  
  scope :latests, -> { order(created_at: :desc).limit(3) }
  scope :bestsellers, -> { best_selling }
  scope :by_category, -> (category) { with_category(category) if category.present?  }
                                      
  scope :sorting_by, -> (param) { param.present? ? send(param) : title_asc }
 
  scope :newest, -> { order(created_at: :desc) }
  scope :popular, -> { best_selling }
  scope :price_lh, -> { order(price: :asc) }
  scope :price_hl, -> { order(price: :desc) }
  scope :title_asc, -> { order(title: :asc) }
  scope :title_desc, -> { order(title: :desc) }
  
  def self.best_selling
    joins(:order_items)
    .order('order_items.qty desc')
  end 
  
  def self.with_category(category)
    joins(:category)
      .where( 'lower(categories.name) = ?', category.downcase)
  end  
  
  mount_uploader :image, BookImageUploader
end
