# defmodule Servy.Plugins do
#   def track(%{status: 200, path: path} = conv ) do
#   formatted_warning = IO.ANSI.blue_background() <> "Success#{path}," <> IO.ANSI.reset()
#   IO.puts(formatted_warning)
#   conv
# end

# def track(%{status: 404, path: path} = conv ) do
#   formatted_warning = IO.ANSI.red_background() <> "Waring: #{path}, not found" <> IO.ANSI.reset()
#   IO.puts(formatted_warning)
#   conv
# end
# def track(%{status: 403, path: path} = conv ) do
#   formatted_warning = IO.ANSI.magenta_background() <> "Forbiden path: #{path} |  Status : #{403} " <> IO.ANSI.reset()
#   IO.puts(formatted_warning)
#   conv
# end
# def track(conv), do: conv

# def rewrite_path( %{path: "/wildlife"} = conv ) do
#   %{conv | path: "/wildthings"}
# end

# def rewrite_path( %{path: "/bears?id=" <> id} = conv ) do
#   # IO.puts(" 🧡 #{id}")
#   %{conv | path: "/bears/" <> id}
# end

# def rewrite_path( conv ), do: conv


# def log(conv), do: IO.inspect conv

# end


# defmodule Servy.Handler do

#   @pages_path  Path.expand("../../pages", __DIR__)

#   import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]

#   @moduledoc """
#   Handles HTTP requests
#   """
#   @doc """
#     Transforms the request into a response
#   """
#   def handle(request) do
#     request
#     |> parse
#     |> rewrite_path
#     |> log
#     |> route
#     |> track
#     |> format_response
#   end

# def parse(request) do
#   # TODO: Parse the request string into a map:

#   # first_line =  request |> String.split("\n") |> List.first
#   # [method, path, _  ] = String.split(first_line , " ")

#   [method , path , _ ] =
#     request
#     |> String.split("\n")
#     |> List.first
#     |> String.split(" ")


#   # conv = %{ method: "GET", path: "/wildthings", resp_body: "" }
#   %{  method: method,
#       path: path ,
#       resp_body: "",
#       status: nil
#     }
# end

# # def route(conv) do #non idiomatic
# #   if conv.path == "wildthings" do
# #     %{conv | resp_body: "Bears, Lions, Tigers"}
# #   else
# #     %{conv | resp_body: "Teddy, Smoking, other bear"}
# #   end
# # end

# # def route(conv) do
# #   route(conv, conv.method,  conv.path)
# # end


# # def route(conv, "GET", "/wildthings") do
# #   %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
# # end

# def route(%{method: "GET" , path: "/wildthings"} = conv) do
#   %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
# end

# # -----------------------------------

# def route(%{method: "GET" , path: "/pages"<> page_subdomain } = conv) do
#   # route(conv, page_subdomain)
#     @pages_path
#   |> Path.join(page_subdomain <> ".html")
#   |> File.read()
#   |> handle_file(conv)
# end

# # -----------------------------------


# def route(%{method: "GET" , path: "/about"} = conv) do
#   @pages_path
#   |> Path.join("about.html")
#   |> File.read()
#   |> handle_file(conv)
# end

# # def route(%{method: "GET" , path: "/about"} = conv) do
# #   file = @pages_path |>
# #    Path.join("about.html")

# #    case File.read(file) do
# #     {:ok, content } ->
# #       #  content =    IO.ANSI.light_black <> IO.ANSI.light_yellow_background() <> content  <>  IO.ANSI.reset()
# #       %{conv | status: 200, resp_body: content}
# #     {:error, :enoent } ->
# #       %{conv | status: 404, resp_body: "File not found!"}
# #     {:error, reason } ->
# #       %{conv | status: 403, resp_body: reason}
# #   end

# # end

# # def route(conv, "GET", "/bears") do
# #   %{conv | status: 200, resp_body: "Teddy, Smoking, other bear"}
# # end

# def route(%{method: "GET" , path: "/bears"} = conv) do
#   %{conv | status: 200, resp_body: "Teddy, Smoking, other bear"}
# end

# # def route(conv, "GET", "/bears/" <> id) do
# #   %{conv | status: 200, resp_body: "Bear #{id}"}
# # end


# def route(%{method: "GET" , path: "/bears/new" } = conv) do
#    @pages_path
#   |> Path.join("form.html")
#   |> File.read()
#   |> handle_file(conv)
# end



# # def route(%{method: "GET" , path: "/bears/new" } = conv) do
# #   form =   @pages_path
# #   |> Path.join("form.html")
# #   |> File.read()

# #   case form do
# #         {:ok, content } ->
# #       %{conv | status: 200, resp_body: content}
# #       {:error, :enoent} ->
# #       %{conv | status: 404, resp_body: "No file!"}
# #       {:error, reason } ->
# #       %{conv | status: 403, resp_body: reason}
# #   end

#   # %{conv | status: 200, resp_body: "Bear #{id}"}
# # end

# def route(%{method: "GET" , path: "/bears"<> id } = conv) do
#   %{conv | status: 200, resp_body: "Bear #{id}"}
# end

# # def route(conv, "DELETE", path) do
# #   %{conv | status: 403, resp_body: "You cannot delete "}
# # end

# def route(%{method: "DELETE" } = conv) do
#   %{conv | status: 403, resp_body: "You cannot delete"}
# end

# # def route(conv, _method, path)do
# #     %{conv | status: 404, resp_body: "No  #{path} here!"}
# # end

# def route(%{ path: path } = conv) do
#   %{conv | status: 404, resp_body: "No #{path} here "}
# end

# def handle_file({:ok, content}, conv) do
#   %{conv | status: 200, resp_body: content}
# end

# def handle_file({:error, :enoent}, conv) do
#   %{conv | status: 404, resp_body: "File not found!"}
# end

# def handle_file({:error, reason}, conv) do
#   %{conv | status: 403, resp_body: reason}
# end


# def format_response(conv) do
#   # TODO: Use values in the map to create an HTTP response string:



#   """
#   HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
#   Content-Type: text/html
#   Content-Length: #{String.length(conv.resp_body)}

#   #{conv.resp_body}
#   """
# end

# defp status_reason(code) do
#   %{
#     200 => "OK",
#     201 => "Created",
#     401 => "Unauthorized",
#     403 => "Forbidden",
#     404 => "Not Found",
#     500 => "Internal Server Error",
#   }[code]
# end


# end

# # request1 = """
# # GET /wildthings HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*

# # """
# # request2 = """
# # GET /bears HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*

# # """
# # request3 = """
# # GET /bigfoot HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*

# # """
# # request4 = """
# # GET /bears/1 HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*

# # """
# # request5 = """
# # DELETE /bears/1 HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*

# # """
# # request6 = """
# # GET /wildlife HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*

# # """
# # request7 = """
# # GET /bears?id=1 HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*

# # """

# # request8 = """
# # GET /about HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*

# # """

# # request9 = """
# # GET /bears/new HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*

# # """

# request10 = """
# GET /pages/contact HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# # IO.puts(" response 1   => \n ______________ \n #{  Servy.Handler.handle(request1)}")
# # IO.puts(" response 2   => \n ______________ \n #{  Servy.Handler.handle(request2)}")
# # IO.puts(" response 3   => \n ______________ \n #{  Servy.Handler.handle(request3)}")
# # IO.puts(" response 4   => \n ______________ \n #{  Servy.Handler.handle(request4)}")
# # IO.puts(" response 5   => \n ______________ \n #{  Servy.Handler.handle(request5)}")
# # IO.puts(" response 6   => \n ______________ \n #{  Servy.Handler.handle(request6)}")
# # IO.puts(" response 7   => \n ______________ \n #{  Servy.Handler.handle(request7)}")
# # IO.puts(" response 8   => \n ______________ \n #{  Servy.Handler.handle(request8)}")
# # IO.puts(" response 9   => \n ______________ \n #{  Servy.Handler.handle(request9)}")
# IO.puts(" response 10   => \n ______________ \n #{  Servy.Handler.handle(request10)}")
