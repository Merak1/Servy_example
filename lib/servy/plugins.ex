defmodule Servy.Plugins do
  alias Servy.Conv
  def track(%Conv{status: 200, path: path} = conv ) do
  formatted_warning = IO.ANSI.blue_background() <> "Success#{path}," <> IO.ANSI.reset()
  IO.puts(formatted_warning)
  conv
end

def track(%Conv{status: 404, path: path} = conv ) do
  formatted_warning = IO.ANSI.red_background() <> "Waring: #{path}, not found" <> IO.ANSI.reset()
  IO.puts(formatted_warning)
  conv
end
def track(%Conv{status: 403, path: path} = conv ) do
  formatted_warning = IO.ANSI.magenta_background() <> "Forbiden path: #{path} |  Status : #{403} " <> IO.ANSI.reset()
  IO.puts(formatted_warning)
  conv
end
def track(%Conv{} = conv), do: conv

def rewrite_path( %Conv{path: "/wildlife"} = conv ) do
  %{conv | path: "/wildthings"}
end

def rewrite_path( %Conv{path: "/bears?id=" <> id} = conv ) do
  # IO.puts(" 🧡 #{id}")
  %{conv | path: "/bears/" <> id}
end

def rewrite_path( %Conv{} = conv ), do: conv


def log(%Conv{} = conv), do: IO.inspect conv

end
