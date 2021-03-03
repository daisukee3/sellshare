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
