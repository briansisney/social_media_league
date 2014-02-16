class Post < ActiveRecord::Base
  belongs_to :page

  validates :entry_id, uniqueness: true
end
