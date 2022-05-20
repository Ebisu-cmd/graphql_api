defmodule GraphqlApiWeb.Resolvers.User do
  alias GraphqlApi.Accounts

  def find_users(params, _), do: Accounts.find_users(params)

  def find_user(%{id: id}, _) do
    id = String.to_integer(id)
    Accounts.find_user(%{id: id})
  end

  def create_user(params, _) do
    Accounts.create_user(params)
  end

  def update_user(%{id: id} = params, _) do
    id = String.to_integer(id)
    Accounts.update_user(id, Map.delete(params, :id))
  end

  def update_user_preferences(%{user_id: id} = params, _) do
    id = String.to_integer(id)
    Accounts.update_user_preferences(id, Map.delete(params, :user_id))
  end
end
