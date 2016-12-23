defmodule Discuss.CommentController do
	use Discuss.Web, :controller

	alias Discuss.Comment
	alias Discuss.User
	alias Discuss.Topic

	def new(conn, _params) do
		changeset = Comment.changeset(%Comment{}, %{})

		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"comment" => comment, "topic_id" => topic_id}) do
		# %{"topic" = topic} = params
		# conn.assigns[:users] is the current user
		topic = Repo.get!(Topic, topic_id)
		changeset = Comment.changeset(%Comment{}, comment)

		changeset = conn.assigns.user # take the current user and pipe it thru as a struct
			|> build_assoc(:comment) # look at the eg "has_many" relationship with whatever is set
			|> Comment.changeset(comment)

		changeset = conn.assigns.topic # take the current user and pipe it thru as a struct
			|> build_assoc(:comment) # look at the eg "has_many" relationship with whatever is set
			|> Comment.changeset(comment)

		case Repo.insert(changeset) do
			{:ok, _comment} -> 
				conn
				|> put_flash(:info, "Comment Created")
				
				render conn, "show.html", topic: topic

			{:error, changeset} -> IO.inspect(changeset)
				render conn, "new.html", changeset: changeset
		end
	end
end