defmodule GraphqlApiWeb.Resolvers.User do
  alias GraphqlApiWeb.User

  def find_user(%{id: id}, _) do
    id = String.to_integer(id)
    User.find_user(%{id: id})
  end

  def find_users(params, _), do: User.find_users(params)

  def create_user(%{id: id} = params, _) do
    id = String.to_integer(id)
    User.create_user(Map.put(params, :id, id))
  end

  def update_user(%{id: id} = params, _) do
    id = String.to_integer(id)
    User.update_user(id, Map.delete(params, :id))
  end

  def update_user_preferences(%{id: id} = params, _) do
    id = String.to_integer(id)
    User.update_user_preferences(id, Map.delete(params, :id))
  end
end


# # reference
# defmodule GraphqlServerWeb.Resolvers.Shop do
#   alias GraphqlServerWeb.Shop
#   def all(params, _), do: Shop.all(params)

#   def find(%{id: id}, _) do
#     id = String.to_integer(id)
#     Shop.find(%{id: id})
#   end

#   def update(%{id: id} = params, _) do
#     id = String.to_integer(id)
#     Shop.update(id, Map.delete(params, :id))
#   end
# end
