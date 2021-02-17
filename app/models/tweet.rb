# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tweet < ApplicationRecord
end
