class Student < ActiveRecord::Base

  def self.get_all
    self.find_by_sql('SELECT * FROM students')
  end

  #returns array of groups, so that used .first
  def self.get_by_id(id)
    self.find_by_sql("SELECT * FROM students WHERE id = #{id}").first
  end



end