defmodule Discuss.Topic do
	use Discuss.Web, :model

	# maps up to the topics table in our database in postgres
	schema "topics" do
		field :title, :string
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:title])
		|> validate_required([:title])
	end
end