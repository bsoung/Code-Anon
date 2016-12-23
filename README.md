# Coders Anonymous (A work in progress)

## An anonymous space for coders to converse, collaborate, and receive help. An exploration into a new lanuage and framework. Utilizes Elixir and Phoenix to power the backend. Frontend is a mix of Phoenix and HTML/CSS.

## Tech stack

	* Phoenix Framework
	* Ueberauth / Ueberauth Github
	* Postgresql
	* Ecto

## API
	
	* GET "/" Returns a list of topics titles
	* GET "/topics/new" Returns a new topic title
	* GET "/topics/:id/edit" Returns an edited version of the topic title
	* POST "/topics" Creates a new topic title
	* PUT "/topics/:id" Creates an updated version of the topic title
	* DELETE "/topics/:id/delete" Deletes a topic based on its id in the database
	* SHOW {IN PROGRESS}


# Phoenix Setup

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
