defmodule GraphqlApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string

    belongs_to :preference, GraphqlApi.Accounts.Preference
  end

  @available_fields [:name, :email]

  def create_changeset(params) do
    changeset(%GraphqlApi.Accounts.User{}, params)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
    |> cast_assoc(:preference)
  end
end
