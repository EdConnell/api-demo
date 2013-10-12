class User < ActiveRecord::Base
  belongs_to :cohort

  def self.create_or_find_user_from_oauth(oauth_hash)
    user = self.find_by_name(oauth_hash.name)
    cohort_id = get_cohort_id(oauth_hash.id)
    unless user
      gravatar = gravatar_url_from_email(oauth_hash.email)
      cohort = Cohort.find_or_create_cohort_by_socrates_id(cohort_id)
      user = self.create(name: oauth_hash.name,
                         gravatar_url: gravatar,
                         cohort_id: cohort.id)
    end
    user.update_cohort_id(cohort_id)
    user
  end

  def self.get_cohort_id(socrates_id)
    DBC::User.find(socrates_id).cohort_id
  end

  def self.gravatar_url_from_email(email)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?size=300"
  end

  def update_cohort_id(current_socrates_id)
    if self.cohort.socrates_id != current_socrates_id
      old_cohort = Cohort.find(self.cohort_id)
      self.cohort = Cohort.find_or_create_cohort_by_socrates_id(current_socrates_id)
      self.cohort.update_student_roster
      old_cohort.update_student_roster
    end
  end
end
