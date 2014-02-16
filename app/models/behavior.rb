class Behavior < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :facebook_id, scope: [:post_id, :behavior_type]
end
