# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  age          :integer
#  gender       :integer
#  introduction :text
#  type         :integer
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

  validates :introduction, presence: true
  validates :introduction, length: { maximum: 300 }

  self.inheritance_column = :_type_disabled

  enum gender: { male: 0, female: 1, other: 2 }
  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, sixtiesover: 5 }
  enum type: { maker: 0, trade: 1, it: 2, ad: 3, human: 4, realestate: 5, consulting: 6, dealer: 7, insurance: 8, finance: 9, typeother: 10 }

end
