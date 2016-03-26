class Group < ActiveRecord::Base

  def self.get_all
    self.find_by_sql('SELECT * FROM groups')
  end

  #returns array of groups, so that used .first
  def self.get_by_id(id)
    self.find_by_sql("SELECT * FROM groups WHERE id = #{id}").first
  end



end