defmodule GraphqlApiWeb.User do
  @users [
    %{
      id: 1,
      name: "Bill",
      email: "bill@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: true,
        likes_faxes: true
      }
    },
    %{
      id: 2,
      name: "Alice",
      email: "alice@gmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: false,
        likes_faxes: true
      }
    },
    %{
      id: 3,
      name: "Jill",
      email: "jill@hotmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: true,
        likes_faxes: false
      }
    },
    %{
      id: 4,
      name: "Tim",
      email: "tim@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: false,
        likes_faxes: false
      }
    }
  ]

  def find_user(%{id: id}) do
    case Enum.find(@users, &(&1.id === id)) do
      nil -> {:error, %{message: "User not found", details: %{id: id}}}
      user -> {:ok, user}
    end
  end

  def find_users(params) do
    filtered_users = Enum.reduce(params, @users, fn {preference, value}, acc ->
      Enum.filter(acc, fn user -> user.preferences[preference] === value end)
    end)
    case filtered_users do
      [] -> {:error, %{message: "Users not found", details: params}}
      users -> {:ok, users}
    end
  end


  def create_user(params) do
    case find_user(%{id: params.id}) do
      {:ok, _user} -> {:error, %{message: "ID is already assigned to existing user", details: %{id: params.id}}}
      _ -> {:ok, params}
    end
  end

  def update_user(id, params) do
    with {:ok, user} <- find_user(%{id: id}) do
      {:ok, Map.merge(user, params)}
    end
  end

  def update_user_preferences(id, params) do
    with {:ok, user} <- find_user(%{id: id}) do
      new_user_preferences = Enum.reduce(params, user.preferences, fn {preference, value}, acc ->
        Map.put(acc, preference, value)
      end)
      {:ok, Map.put(new_user_preferences, :user_id, user.id)}
    end
  end
end
