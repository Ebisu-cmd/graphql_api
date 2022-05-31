defmodule GraphqlApi.Accounts do
  alias GraphqlApi.Accounts.User
  alias GraphqlApi.Accounts.Preference
  alias EctoShorts.Actions
  alias GraphqlApi.Repo


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
    preference = find_existing_preference_or_return_params(params.preference)
    Actions.create(User, Map.put(params, :preference, preference))
  end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  def update_user_preferences(id, params) do
    case construct_new_preference(id, params) do
      {:ok, new_preference} -> update_user_preference_and_append_user_id(id, new_preference)
      {:error, error_message} -> {:error, error_message}
    end
  end

  defp construct_new_preference(id, params) do
    case find_user(%{id: id}) do
      {:ok, user} ->
        user = Repo.preload(user, :preference)
        {new_params, _} = Map.merge(user.preference, params) |> Map.split(@user_preferences)
        {:ok, find_existing_preference_or_return_params(new_params)}

      {:error, error_message} -> {:error, error_message}
    end
  end

  defp find_existing_preference_or_return_params(params) do
    case Actions.find(Preference, params) do
      {:ok, found_existing_preference} -> found_existing_preference
      {:error, _} -> params
    end
  end

  defp update_user_preference_and_append_user_id(id, preference) do
    case Actions.update(User, id, %{preference: preference}) do
      {:ok, user} -> {:ok, Map.put(user.preference, :user_id, id)}
      {:error, error_message} -> {:error, error_message}
    end
  end

end
