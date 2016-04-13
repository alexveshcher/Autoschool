class Student < ActiveRecord::Base

  validates :phone, length: { is: 10 }
  validates :firstname, :lastname, :patronymic, format: { with: /\A[a-zA-Z]+\z/,
                                                           message: 'only allows letters' }

  def self.get_all
    self.find_by_sql('SELECT * FROM students')
  end

  #returns array of groups, so that used .first
  def self.get_by_id(id)
    self.find_by_sql("SELECT * FROM students WHERE id = #{id}").first
  end

  def passed_school?
    self.read_attribute(:passed_school) == "\x01" ? true : false
  end

  def passed_mreo?
    self.read_attribute(:passed_mreo) == "\x01" ? true : false
  end

end