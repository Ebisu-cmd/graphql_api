defmodule GraphqlApiWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation

  alias GraphqlApiWeb.Resolvers

  object :user_queries do
    field :user, :user do
      arg :id, non_null(:id)

      resolve &Resolvers.User.find_user/2
    end

    field :users, list_of(:user) do
      arg :likes_emails, :boolean
      arg :likes_phone_calls, :boolean
      arg :likes_faxes, :boolean
      arg :first, :integer
      arg :before, :integer
      arg :after, :integer

      resolve &Resolvers.User.find_users/2
    end
  end
end
