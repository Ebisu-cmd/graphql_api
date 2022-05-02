defmodule GraphqlApiWeb.Schema do
  use Absinthe.Schema

  import_types GraphqlApiWeb.Types.User

  import_types GraphqlApiWeb.Schema.Queries.User
  import_types GraphqlApiWeb.Schema.Mutations.User
  import_types GraphqlApiWeb.Schema.Subscriptions.User

  query do
    import_fields :user_queries
  end

  mutation do
    import_fields :user_mutations
  end

  subscription do
    import_fields :user_subscriptions
  end
end
