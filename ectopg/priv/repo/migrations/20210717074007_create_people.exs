defmodule Ectopg.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    # add these lines to create a table people with the specified fields
    create table(:people) do
      add :first_name, :string
      add :last_name, :string
      add :age, :integer
    end
  end
end
