defmodule GraphqlApi.Repo.Migrations.CreatePreferences do
  use Ecto.Migration

  def change do
    create table(:preferences) do
      add :likes_emails, :boolean, default: false, null: false
      add :likes_phone_calls, :boolean, default: false, null: false
      add :likes_faxes, :boolean, default: false, null: false
    end

    create index(:preferences, [:likes_emails])
    create index(:preferences, [:likes_phone_calls])
    create index(:preferences, [:likes_faxes])
  end
end
