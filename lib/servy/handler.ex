
defmodule Servy.Handler do

  # @pages_path  Path.expand("../../pages", __DIR__)
  @pages_path Path.expand("pages", File.cwd!)

  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Servy.Parser, only: [parse: 1]
  import Servy.HandleFile

  alias Servy.Conv



  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  def route(%Conv{method: "GET" , path: "/wildthings"} = conv) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET" , path: "/pages"<> page_subdomain } = conv) do
      @pages_path
    |> Path.join(page_subdomain <> ".html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET" , path: "/about"} = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)
  end


  def route(%Conv{method: "GET" , path: "/bears"} = conv) do
    %{conv | status: 200, resp_body: "Teddy, Smoking, other bear"}
  end

  # name=Baloo&type=Brown
  def route(%Conv{method: "POST" , path: "/bears"} = conv) do
    %{conv | status: 201,
     resp_body: "Created a #{conv.params["type"]} bear named #{conv.params["name"]}"}
  end

  def route(%Conv{method: "GET" , path: "/bears/new" } = conv) do
    @pages_path
    |> Path.join("form.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET" , path: "/bears"<> id } = conv) do
    %{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def route(%Conv{method: "DELETE" } = conv) do
    %{conv | status: 403, resp_body: "You cannot delete"}
  end

  def route(%Conv{ path: path } = conv) do
    %{conv | status: 404, resp_body: "No #{path} here "}
  end


  def format_response(%Conv{ } = conv) do

  """
  HTTP/1.1 #{Conv.full_status(conv)}
  Content-Type: text/html
  Content-Length: #{String.length(conv.resp_body)}

  #{conv.resp_body}
  """
  end

end

# request1 = """
# GET /wildthings HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# request2 = """
# GET /bears HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# request3 = """
# GET /bigfoot HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# request4 = """
# GET /bears/1 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# request5 = """
# DELETE /bears/1 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# request6 = """
# GET /wildlife HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# request7 = """
# GET /bears?id=1 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# request8 = """
# GET /about HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# request9 = """
# GET /bears/new HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# request10 = """
# GET /pages/contact HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
request11 = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: applicaiton/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""

  # Servy.Helpers.custom_log_servy_handler(request1)
  # Servy.Helpers.custom_log_servy_handler(request2)
  # Servy.Helpers.custom_log_servy_handler(request3)
  # Servy.Helpers.custom_log_servy_handler(request4)
  # Servy.Helpers.custom_log_servy_handler(request5)
  # Servy.Helpers.custom_log_servy_handler(request6)
  # Servy.Helpers.custom_log_servy_handler(request7)
  # Servy.Helpers.custom_log_servy_handler(request8)
  # Servy.Helpers.custom_log_servy_handler(request9)
  # Servy.Helpers.custom_log_servy_handler(request10)
  Servy.Helpers.custom_log_servy_handler(request11)
