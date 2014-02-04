class Cohort < ActiveRecord::Base
  has_many :users
  has_many :games

  def self.find_or_create_cohort_by_socrates_id(id)
    cohort = self.find_by_socrates_id(id)
    unless cohort
      cohort = self.create(name: get_cohort_info(id).name,
                           socrates_id: id)
      cohort.update_student_roster
    end

    cohort
  end

  def self.get_cohort_info(id)
    DBC::Cohort.find(id)
  end

  def update_student_roster
    students = self.class.get_cohort_info(self.socrates_id).students
    students = clean_user_info(students).compact
    self.users = students
    self.save
  end

  def clean_user_info(roster)
    counter = 0
    roster.map do |student|
      next unless student.roles.include?('student') && !student.roles.include?('admin')
      user = User.find_by_name(student.name)
      unless user
        gravatar_url = User.gravatar_url_from_email(student.email)
        user = User.create(name: student.name,
                    gravatar_url: gravatar_url)
      end
      user
    end
  end

  def student_count
    self.users.where(role: "student")
  end
end
