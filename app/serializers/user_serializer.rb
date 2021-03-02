class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :account, :avatar_comment_image

  has_one :profile

  def avatar_comment_image
    rails_blob_path(object.profile.avatar) if object.profile.avatar.attached?
  end

end

