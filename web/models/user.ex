defmodule Discuss.User do
	use Discuss.Web, :model

	schema "users" do
		field :email, :string
		field :provider, :string
		field :token, :string
		 # this user has many topics and each topic should use the module of Discuss.Topic - a direct ref to our topic model
		has_many :topics, Discuss.Topic
		has_many :comments, Discuss.Comment

		timestamps()
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:email, :provider, :token])
		|> validate_required([:email, :provider, :token])
	end
end