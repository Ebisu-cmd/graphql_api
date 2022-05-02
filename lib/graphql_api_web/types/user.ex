defmodule GraphqlApiWeb.Types.User do
  use Absinthe.Schema.Notation

  @desc "The preferences a user can have for communication"
  object :user_preferences do
    field :likes_emails, :boolean
    field :likes_phone_calls, :boolean
  end

  @desc "A user that has preferences for communication"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :preferences, :user_preferences
  end
end
