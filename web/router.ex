defmodule Discuss.Router do
  use Discuss.Web, :router

  # before any req that goes into any route defined in the scope, we wanna do some pre processing to those req
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Discuss.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # namespace any url's inside our app.
  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    # get "/", TopicController, :index
    # get "/topics/new", TopicController, :new # handle get request to make a new topic
    # post "/topics", TopicController, :create
    # get "/topics/:id/edit", TopicController, :edit
    # put "/topics/:id", TopicController, :update
    # show ... - covered in our resources
    
    resources "/", TopicController # phoenix automatically synthesizes all these restful routes for us as long as we are following restful naming
  end

  scope "/auth", Discuss do
    pipe_through :browser 

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request # request is defined auto by our ueberauth plug
    get "/:provider/callback", AuthController, :callback # this is the function we defined in the controller
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
