defmodule GraphqlApi.Accounts do
  alias GraphqlApi.Accounts.User
  alias EctoShorts.Actions


  @user_preferences [:likes_emails, :likes_faxes, :likes_phone_calls]

  def find_users(params \\ %{}) do
    new_params = group_preferences_filters_in_params(params)
    case User.by_preference(new_params.preference) |> Actions.all(Map.delete(new_params, :preference)) do
      [] -> {:error, %{message: "Users not found", details: params}}
      users -> {:ok, users}
    end
  end

  defp group_preferences_filters_in_params(params) do
    Enum.reduce(params, %{preference: %{}}, fn {filter, value}, acc ->
      if filter in @user_preferences do
        put_in(acc, [:preference, filter], value)
      else
        Map.put(acc, filter, value)
      end
    end)
  end

  def find_user(params) do
    Actions.find(User, params)
  end

  def create_user(params) do
    Actions.create(User, params)
  end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  def update_user_preferences(id, params) do
    case Actions.update(User, id, %{preference: params}) do
      {:ok, user} -> {:ok, Map.put(user.preference, :user_id, id)}
      {:error, error_message} -> {:error, error_message}
    end
  end
end
