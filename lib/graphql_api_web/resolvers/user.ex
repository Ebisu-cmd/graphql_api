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

  def update_user_preferences(%{user_id: id} = params, _) do
    id = String.to_integer(id)
    User.update_user_preferences(id, Map.delete(params, :user_id))
  end
end
