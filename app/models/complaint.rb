# == Schema Information
#
# Table name: complaints
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_complaints_on_user_id  (user_id)
#
class Complaint < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true
  validates :content, length: { maximum: 300 }

  belongs_to :user
end
