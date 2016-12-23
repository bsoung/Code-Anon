defmodule Discuss.TopicController do
	use Discuss.Web, :controller # imports ecto module, repo is in Ecto module

	alias Discuss.Topic

	# this plug will execute before any handler in this file
	plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

	# function plug, used in a singular function
	plug :check_topic_owner when action in [:update, :edit, :delete]

	def index(conn, _params) do
		IO.inspect(conn.assigns)
		topics = Repo.all(Topic)
		render conn, "index.html", topics: topics
	end

	def show(conn, %{"id" => topic_id}) do
		topic = Repo.get!(Topic, topic_id)
		render conn, "show.html", topic: topic
	end

	def new(conn, _params) do
		changeset = Topic.changeset(%Topic{}, %{})

		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"topic" => topic}) do
		# %{"topic" = topic} = params
		# conn.assigns[:users] is the current user
		changeset = Topic.changeset(%Topic{}, topic)

		changeset = conn.assigns.user # take the current user and pipe it thru as a struct
			|> build_assoc(:topics) # look at the eg "has_many" relationship with whatever is set
			|> Topic.changeset(topic)

		case Repo.insert(changeset) do
			{:ok, _topic} -> 
				conn
				|> put_flash(:info, "Topic Created")
				|> redirect(to: topic_path(conn, :index))
			{:error, changeset} -> IO.inspect(changeset)
				render conn, "new.html", changeset: changeset
		end
	end

	def edit(conn, %{"id" => topic_id}) do # pattern matching to put id into our topic_id
		topic = Repo.get(Topic, topic_id) # will find a single record out of our db with this particular id
		changeset = Topic.changeset(topic)

		render conn, "edit.html", changeset: changeset, topic: topic # need topic as well because we need to have an id
	end

	def update(conn, %{"id" => topic_id, "topic" => topic}) do
		# %{"id" = topic_id, "topic" = topic} = params
		old_topic = Repo.get(Topic, topic_id) # fetch out of db
		changeset = Topic.changeset(old_topic, topic) # first arg is a struct - representing record in db, second is the new attributes

		case Repo.update(changeset) do
			{:ok, _topic} ->
				conn
				|> put_flash(:info, "Topic Updated")
				|> redirect(to: topic_path(conn, :index))
			{:error, changeset} ->
				render conn, "edit.html", changeset: changeset, topic: old_topic
		end
	end

	def delete(conn, %{"id" => topic_id}) do
		Repo.get!(Topic, topic_id) |> Repo.delete! # ! bang means if topic does not exist, send back error
		conn
		|> put_flash(:info, "Topic Deleted")
		|> redirect(to: topic_path(conn, :index))
	end

	# prevent someone from hotlinking to an authorized page
	def check_topic_owner(conn, _params) do
		%{params: %{"id" => topic_id}} = conn # get the topic id
		if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
			conn
		else
			conn
			|> put_flash(:error, "You cannot edit that")
			|> redirect(to: topic_path(conn, :index))
			|> halt() # stop at this plug, don't send it onwards
		end
	end
end








