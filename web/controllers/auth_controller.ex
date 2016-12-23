defmodule Discuss.AuthController do
	use Discuss.Web, :controller
	plug Ueberauth # notes

	alias Discuss.User

	def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
		# create our user
		user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
		changeset = User.changeset(%User{}, user_params)

		signin(conn, changeset)
	end

	def signout(conn, _params) do
		conn
		|> configure_session(drop: true) # any session we have with user, drop it all
		|> redirect(to: topic_path(conn, :index))
	end

	# private functions cannot be called by any other modules
	defp signin(conn, changeset) do
		case insert_or_update_user(changeset) do
			{:ok, user} ->
				conn
				|> put_flash(:info, "Welcome back!")
				|> put_session(:user_id, user.id) # store in cookies
				|> redirect(to: topic_path(conn, :index))

			{:error, :no_mail} ->
				conn
				|> put_flash(:error, "Error signing in")
				|> redirect(to: topic_path(conn, :index))
		end
	end

	######## REFACTOR THE IF STATEMENT #########
	defp insert_or_update_user(changeset) do
		if Map.has_key?(changeset.changes, :email) do
			case Repo.get_by(User, email: changeset.changes.email) do
			nil ->
				Repo.insert(changeset)
			user ->
				{:ok, user}
			end
		else
			{:error, :no_mail}
		end
	end
	
end