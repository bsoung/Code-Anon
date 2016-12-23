defmodule Discuss.Plugs.RequireAuth do
	import Plug.Conn 
	import Phoenix.Controller

	alias Discuss.Router.Helpers
	# required to define this function even if we don't use it
	def init(_params) do
		
	end

	# called every single time a req is flowed through this plug
	# decided what users see depending if signed in or not
	def call(conn, _params) do
		if conn.assigns[:user] do
			conn # continue on!
		else
			conn
			|> put_flash(:error, "You must be logged in")
			|> redirect(to: Helpers.topic_path(conn, :index)) 
			|> halt() # we're done!
		end
	end
end