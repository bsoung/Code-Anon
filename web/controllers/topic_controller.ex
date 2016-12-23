defmodule Discuss.TopicController do
	use Discuss.Web, :controller

	alias Discuss.Topic

	def index(conn, _params) do
		IO.inspect(conn.assigns)
		topics = Repo.all(Topic)
		render conn, "index.html", topics: topics
	end

	def new(conn, _params) do
		# struct = %Topic{}
		# params = %{}
		changeset = Topic.changeset(%Topic{}, %{})

		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"topic" => topic}) do
		# %{"topic" = topic} = params
		changeset = Topic.changeset(%Topic{}, topic)

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
end








