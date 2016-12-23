defmodule Discuss.Plugs.SetUser do
	import Plug.Conn # helper functions working with conn struct
	import Phoenix.Controller # involve sessions

	alias Discuss.Repo
	alias Discuss.User
	alias Discuss.Router.Helpers

	def init(_params) do 
		
	end

	def call(conn, _params) do # _params is whatever we would have returned from the init function
		user_id = get_session(conn, :user_id)

		cond do # condition statement - first statement that is true is executed
			user = user_id && Repo.get(User, user_id) ->
				assign(conn, :user, user)
				# conn.assigns.user => user struct
				
			true -> # if no user
				assign(conn, :user, nil)
		end
	end
end