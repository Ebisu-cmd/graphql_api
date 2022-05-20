defmodule GraphqlApi.Accounts do
  alias GraphqlApi.Accounts.User
  alias GraphqlApi.Accounts.Preference
  alias EctoShorts.Actions

  def find_users(params \\ %{}) do
    params = Enum.reduce(params, %{preference: %{}}, fn {filter, value}, acc ->
      case Enum.member?([:likes_emails, :likes_faxes, :likes_phone_calls], filter) do
        true ->  put_in(acc, [:preference, filter], value)
        false -> Map.put(acc, filter, value)
      end
    end)
   {:ok, Actions.all(User, params)}
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
    {_, user} = find_user(%{id: id})
    {_, preference} = Actions.update(Preference, user.preference_id, params)
    {:ok,  Map.put(preference, :user_id, id)}
  end
end
