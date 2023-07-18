defmodule Servy.Helpers do
  def custom_log_servy_handler(request) do
       IO.puts(Servy.Handler.handle(request))
      # "ee"
  end

  def red(element) do
     warning =  IO.ANSI.red_background() <> "#{element}" <> IO.ANSI.reset()
     IO.puts(warning)
  end

  def green(element) do
     IO.puts( IO.ANSI.green_background() <> "#{element}" <> IO.ANSI.reset())
  end

  def blue(element) do
     IO.puts( IO.ANSI.blue_background() <> "#{element}" <> IO.ANSI.reset())
  end
  def magenta(element) do
     IO.puts( IO.ANSI.magenta_background() <> "#{element}" <> IO.ANSI.reset())
  end
  def yellow(element) do
     IO.puts( IO.ANSI.yellow_background() <>IO.ANSI.black() <> "#{element}" <> IO.ANSI.reset())
  end



end
