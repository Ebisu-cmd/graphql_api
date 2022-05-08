defmodule GraphqlApiWeb.Schema.Subscriptions.User do
  use Absinthe.Schema.Notation

  object :user_subscriptions do
    field :created_user, :user do

      config fn _, _ ->
        {:ok, topic: "new_user"}
      end

      trigger :create_user, topic: fn _ ->
        "new_user"
      end
    end

    field :updated_user_preferences, :user_preferences do
      arg :user_id, non_null(:id)

      config fn args, _ ->
        {:ok, topic: "User: #{args.user_id}"}
      end

      trigger :update_user_preferences, topic: fn preference ->
        "User: #{preference.user_id}"
      end
    end
  end
end
