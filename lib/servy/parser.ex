defmodule Servy.Parser do
  alias Servy.Conv
  # import Servy.Helpers

  def parse(request) do
    # import Servy , only: [Conv :3]
    # first_line =  request |> String.split("\n") |> List.first
    # [method, path, _  ] = String.split(first_line , " ")

  [top, params_string] =   String.split(request, "\n\n")
  [request_line | header_lines ] = String.split(top, "\n")

  # magenta(header_lines)

  [method, path , _ ] = String.split(request_line, " ")
  headers = parse_headers(header_lines, %{})
    # magenta(headers)
  # [method , path , _ ] =
  #   top
  #   |> String.split("\n")
  #   |> List.first
  #   |> String.split(" ")

    params = parse_params(headers["Content-Type"],params_string)

  %Conv{
      method: method,
      path: path ,
      params: params,
      headers: headers
    }
  # conv = %{ method: "GET", path: "/wildthings", resp_body: "" }
  # %{  method: method,
  #     path: path ,
  #     resp_body: "",
  #     status: nil
  #   }
end
  def parse_headers( [head | tail], headers) do
    [key , value] = String.split(head, ": ")
    # IO.inspect(head)
    # green("- key:  #{key}   -")
    # yellow("-  value:  #{value}   -")
    # magenta("-----")
    headers = Map.put(headers, key, value)

    # IO.inspect(headers)
    # green(headers)

    parse_headers(tail, headers)
  end


  def parse_headers([], headers), do: headers


  def parse_params("applicaiton/x-www-form-urlencoded",params_string)do
    params_string |> String.trim |> URI.decode_query
  end

  def parse_params(  _ , _params_string), do: %{}


end
