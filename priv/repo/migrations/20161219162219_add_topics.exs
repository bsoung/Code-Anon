# mix ecto.gen.migration add_topics
defmodule Discuss.Repo.Migrations.AddTopics do # helps communicate with our postgresql database
  use Ecto.Migration

  def change do
  	# tell postgres to create a new table called 'topics', inside - make sure there is a column called table with a type "string"
  	create table(:topics) do
  		add :title, :string
  	end
  end
end
