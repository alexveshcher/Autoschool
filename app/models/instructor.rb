class Instructor < ActiveRecord::Base
  has_one :worker, foreign_key: 'id'
end