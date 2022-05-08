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
    @users
    |> filter_users_who_like_emails(params)
    |> filter_users_who_like_phone_calls(params)
    |> filter_users_who_like_faxes(params)
    |> find_users_error_check(params)
  end

  defp filter_users_who_like_emails(users, params) do
    if Map.has_key?(params, :likes_emails) do
      Enum.filter(users, &(&1.preferences.likes_emails === params.likes_emails))
    else
      users
    end
  end

  defp filter_users_who_like_phone_calls(users, params) do
    if Map.has_key?(params, :likes_phone_calls) do
      Enum.filter(users, &(&1.preferences.likes_phone_calls === params.likes_phone_calls))
    else
      users
    end
  end

  defp filter_users_who_like_faxes(users, params) do
    if Map.has_key?(params, :likes_faxes) do
      Enum.filter(users, &(&1.preferences.likes_faxes === params.likes_faxes))
    else
      users
    end
  end

  defp find_users_error_check(users, params) do
    case users do
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
      user.preferences
      |> update_users_email_preference(params)
      |> update_users_phone_preference(params)
      |> update_users_fax_preference(params)
      |> add_user_id_for_subscription(user)
    end
  end

  defp update_users_email_preference(user_preferences, params) do
    %{likes_emails: likes_emails} = params
    Map.merge(user_preferences, %{likes_emails: likes_emails})
  end

  defp update_users_phone_preference(user_preferences, params) do
    if Map.has_key?(params, :likes_phone_calls) do
      %{likes_phone_calls: likes_phone_calls} = params
      Map.merge(user_preferences, %{likes_phone_calls: likes_phone_calls})
    else
      user_preferences
    end
  end

  defp update_users_fax_preference(user_preferences, params) do
    if Map.has_key?(params, :likes_faxes) do
      %{likes_faxes: likes_faxes} = params
      Map.merge(user_preferences, %{likes_faxes: likes_faxes})
    else
      user_preferences
    end
  end

  defp add_user_id_for_subscription(user_preferences, user) do
    {:ok ,Map.merge(user_preferences, %{user_id: user.id})}
  end
end
