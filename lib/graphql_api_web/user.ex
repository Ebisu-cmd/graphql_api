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

  def find_users(%{likes_emails: likes_emails, likes_phone_calls: likes_phone_calls}) do
    case Enum.filter(@users, &(&1.preferences.likes_emails === likes_emails && &1.preferences.likes_phone_calls === likes_phone_calls)) do
      [] -> {:error, %{message: "Users not found", details: %{likes_emails: likes_emails, likes_phone_calls: likes_phone_calls}}}
      users -> {:ok, users}
    end
  end

  def find_users(%{likes_emails: likes_emails}) do
    case Enum.filter(@users, &(&1.preferences.likes_emails === likes_emails)) do
      [] -> {:error, %{message: "Users not found", details: %{likes_emails: likes_emails}}}
      users -> {:ok, users}
    end
  end

  def find_users(%{likes_phone_calls: likes_phone_calls}) do
    case Enum.filter(@users, &(&1.preferences.likes_phone_calls === likes_phone_calls)) do
      [] -> {:error, %{message: "Users not found", details: %{likes_phone_calls: likes_phone_calls}}}
      users -> {:ok, users}
    end
  end

  def find_users(_), do: {:ok, @users}

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

  def update_user_preferences(id, %{likes_emails: likes_emails, likes_phone_calls: likes_phone_calls}) do
    with {:ok, user} <- find_user(%{id: id}) do
      new_preferences = %{preferences: %{likes_emails: likes_emails, likes_phone_calls: likes_phone_calls}}
      {:ok, Map.merge(user, new_preferences)}
    end
  end

  def update_user_preferences(id, %{likes_emails: likes_emails}) do
    with {:ok, user} <- find_user(%{id: id}) do
      new_preferences = %{preferences: Map.put(user.preferences, :likes_emails, likes_emails)}
      {:ok, Map.merge(user, new_preferences)}
    end
  end
end
