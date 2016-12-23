defmodule Discuss.Topic do
	use Discuss.Web, :model

	# maps up to the topics table in our database in postgres
	schema "topics" do
		field :title, :string
		# belongs to a single user, and you can find more info in the Discuss.User module
		belongs_to :user, Discuss.User
		has_many :comments, Discuss.Comment 
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:title])
		|> validate_required([:title])
	end
end