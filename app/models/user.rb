class User < ActiveRecord::Base
  belongs_to :team
  has_many :behaviors
  has_many :pages
  
end
