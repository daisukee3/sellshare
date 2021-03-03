class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :avatar, :age, :gender, :type
  belongs_to :user
end
