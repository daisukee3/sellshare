# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  age          :integer
#  gender       :integer
#  introduction :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  enum gender: { male: 0, female: 1, other: 2 }
  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, sixtiesover: 5 }
end
