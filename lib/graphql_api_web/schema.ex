defmodule GraphqlApiWeb.Schema do
  use Absinthe.Schema

  import_types GraphqlApiWeb.Types.User

  import_types GraphqlApiWeb.Schema.Queries.User

  query do
    import_fields :user_queries
  end
end







# # reference --------------------------------------
# defmodule GraphqlServerWeb.Schema do
#   use Absinthe.Schema

#   import_types GraphqlServerWeb.Types.Shop

#   import_types GraphqlServerWeb.Schema.Queries.Shop
#   import_types GraphqlServerWeb.Schema.Mutations.Shop

#   query do
#     import_fields :shop_queries
#   end

#   mutation do
#     import_fields :shop_mutations
#   end
# end
