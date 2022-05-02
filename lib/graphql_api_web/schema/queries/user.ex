defmodule GraphqlApiWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation

  alias GraphqlApiWeb.Resolvers

  object :user_queries do
    field :user, :user do
      arg :id, non_null(:id)

      #make function (ex: resolve &Resolvers.Shop.find/2)
    end

    field :users, list_of(:users) do
      arg :likes_emails, :boolean
      arg :likes_phone_calls, :boolean

      #make function (ex: resolve &Resolvers.Shop.all/2)
    end
  end
end
