defmodule GraphqlApi.Accounts do
  alias GraphqlApi.Accounts.User
  alias GraphqlApi.Accounts.Preference
  alias EctoShorts.Actions
  alias GraphqlApi.Repo


  @user_preferences [:likes_emails, :likes_faxes, :likes_phone_calls]

  def find_users(params \\ %{}) do
    params = Enum.reduce(params, %{preference: %{}}, fn {filter, value}, acc ->
      case Enum.member?(@user_preferences, filter) do
        true ->  put_in(acc, [:preference, filter], value)
        false -> Map.put(acc, filter, value)
      end
    end)
    case Actions.all(User, params) do
      [] -> {:error, %{message: "Users not found", details: params}}
      users -> {:ok, users}
    end
  end

  def find_user(params) do
    Actions.find(User, params)
  end

  def create_user(params) do
    params = case find_preference(params.preference) do
      {:ok, preference} -> Map.put(params, :preference, preference)
      _ -> params
    end
    Actions.create(User, params)
  end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  def update_user_preferences(id, params) do
    {_, user} = find_user(%{id: id})
    user = Repo.preload(user, :preference)
    {new_params, _} = Map.merge(user.preference, params) |> Map.split(@user_preferences)
    new_preference = case find_preference(new_params) do
      {:ok, found_existing_preference} -> found_existing_preference
      {:error, _} -> new_params
    end
    {:ok, user} = Actions.update(User, id, %{preference: new_preference})
    {:ok, Map.put(user.preference, :user_id, id)}
  end


  defp find_preference(params) do
    Actions.find(Preference, params)
  end
end
