class Lector < ActiveRecord::Base
  has_one :worker, foreign_key: 'id'
  #accepts_nested_attributes_for :worker
end