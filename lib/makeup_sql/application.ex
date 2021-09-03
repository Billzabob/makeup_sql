defmodule MakeupSql.Application do
  @moduledoc false
  use Application

  alias Makeup.Registry

  def start(_type, _args) do
    Registry.register_lexer(MakeupSql,
      options: [],
      names: ["sql"],
      extensions: ["sql"]
    )

    Supervisor.start_link([], strategy: :one_for_one)
  end
end
