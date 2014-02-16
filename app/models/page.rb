class Page < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  
  validates :facebook_id, uniqueness: true
end
