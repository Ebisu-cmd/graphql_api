defmodule GraphqlApiWeb.User do
  @users [
    %{
      id: 1,
      name: "Bill",
      email: "bill@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: true
      }
    },
    %{
      id: 2,
      name: "Alice",
      email: "alice@gmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: false
      }
    },
    %{
      id: 3,
      name: "Jill",
      email: "jill@hotmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: true
      }
    },
    %{
      id: 4,
      name: "Tim",
      email: "tim@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: false
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
    {:ok, [params | @users]}
  end



  # # reference -------------------------------------------------------------
  # def update(id, params) do
  #   with {:ok, shop} <- find(%{id: id}) do
  #     {:ok, Map.merge(shop, params)}
  #   end
  # end


end
