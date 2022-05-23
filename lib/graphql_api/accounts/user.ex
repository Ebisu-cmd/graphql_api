defmodule GraphqlApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias EctoShorts.CommonChanges

  schema "users" do
    field :email, :string
    field :name, :string

    belongs_to :preference, GraphqlApi.Accounts.Preference, on_replace: :nilify
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
    |> CommonChanges.preload_changeset_assoc(:preference)
    |> CommonChanges.put_or_cast_assoc(:preference)
  end
end
