defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  def change do
  	alter table(:topics) do
  		add :user_id, references(:users) # this is going to be user id with a reference to our users table
  	end
  end
end
