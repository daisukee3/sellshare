# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account                :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_account               (account) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :account, :avatar_image, :author_image

  has_one :profile

  def author_image
      rails_blob_path(object.avatar_image) if object.avatar_image.attached?
    end
end


# , :avatar_comment_image
# def author_image
#   if object.avatar_image != 'default-avatar.png'
#     rails_blob_path(object.avatar_image)
#   else
#     '/assets/images/default-avatar.png'
#   end
# end
