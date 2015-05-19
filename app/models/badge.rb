class Badge < ActiveRecord::Base
  has_many :awards, dependent: :destroy
  has_many :users, through: :awards
end
