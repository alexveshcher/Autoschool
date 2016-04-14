class Lection < ActiveRecord::Base
  belongs_to :group
  belongs_to :lector
end