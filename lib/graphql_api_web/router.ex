defmodule GraphqlApiWeb.Router do
  use GraphqlApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: GraphqlApiWeb.Schema

    if Mix.env() === :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        interface: :playground,
        schema: GraphqlApiWeb.Schema,
        socket: GraphqlApiWeb.UserSocket
    end
  end
end
