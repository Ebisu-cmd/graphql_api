defmodule GraphqlApiWeb.Types.User do
  use Absinthe.Schema.Notation

  @desc "Alows user_preferences to be a nested argument in our mutations"
  input_object :preferences do
    field :likes_emails, non_null(:boolean)
    field :likes_phone_calls, non_null(:boolean)
  end

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
