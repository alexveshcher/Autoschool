class Student < ActiveRecord::Base

  validates :category, inclusion: { in: %w(A B C),
                                    message: 'no such category'}
  validates :phone, length: { is: 10 }
  validates :firstname, :lastname, :fathersname, format: { with: /\A[a-zA-Z]+\z/,
                                                           message: 'only allows letters' }

  def self.get_all
    self.find_by_sql('SELECT * FROM students')
  end

  #returns array of groups, so that used .first
  def self.get_by_id(id)
    self.find_by_sql("SELECT * FROM students WHERE id = #{id}").first
  end



end