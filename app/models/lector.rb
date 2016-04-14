class Lector < ActiveRecord::Base
  has_one :worker, foreign_key: 'id'
  has_many :lections
  #accepts_nested_attributes_for :worker
end