class Instructor < ActiveRecord::Base
  has_one :worker, foreign_key: 'id'

  def self.top3
    self.find_by_sql("
SELECT i.*, count(DISTINCT(students.id))
FROM trainings
  INNER JOIN instructors i ON trainings.instructor_id = i.id
  INNER JOIN students ON students.id = trainings.student_id
WHERE students.passed_mreo = true
GROUP BY i.id
LIMIT 3")
  end
end