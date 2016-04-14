class Worker < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :lector

end