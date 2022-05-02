defmodule GraphqlApiWeb.Schema.Mutations.User do
  use Absinthe.Schema.Notation

  alias GraphqlApiWeb.Resolvers

  object :user_mutations do
    field :create_user, :user do
      arg :id, non_null(:id)
      arg :name, non_null(:string)
      arg :email, non_null(:string)
      arg :preferences, non_null(:preferences)

      resolve &Resolvers.User.create_user/2
    end

    field :update_user, :user do
      arg :id, non_null(:id)
      arg :name, :string
      arg :email, :string

      resolve &Resolvers.User.update_user/2
    end

    field :update_user_preferences, :user do
      arg :id, non_null(:id)
      arg :likes_emails, non_null(:boolean)
      arg :likes_phone_calls, :boolean

      resolve &Resolvers.User.update_user_preferences/2
    end
  end
end
