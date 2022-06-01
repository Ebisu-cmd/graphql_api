defmodule GraphqlApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias EctoShorts.CommonChanges

  schema "users" do
    field :email, :string
    field :name, :string

    belongs_to :preference, GraphqlApi.Accounts.Preference, on_replace: :update
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
    |> CommonChanges.preload_change_assoc(:preference)
  end

  def join_preference(query \\ GraphqlApi.Accounts.User) do
    join(query, :inner, [u], p in assoc(u, :preference), as: :preference)
  end

  def by_preference(query \\ join_preference(), preferences) do
    Enum.reduce(preferences, query, fn {filter, value}, acc ->
      where(acc, [preference: p], field(p, ^filter) == ^value)
    end)
  end
end
