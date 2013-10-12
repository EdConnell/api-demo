# => Gravatar image by email = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?size=300"
class User < ActiveRecord::Base

  def self.create_or_find_user_from_oauth(oauth_hash)
    user = self.find_by_name(oauth_hash.name)
    unless user
      user = self.create(name: oauth_hash.name,
                         gravatar_url: oauth_hash.gravatar,
                         cohort_id: get_cohort_id(oauth_hash.id))
    end
    user
  end

  def self.get_cohort_id(socrates_id)
    DBC::User.find(socrates_id).cohort_id
  end
end
