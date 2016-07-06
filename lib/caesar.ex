defmodule Caesar do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Caesar.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Caesar.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def main argv do
    argv
      |> parse_args
      |> process
    System.halt(0)
  end

  def parse_args argv do
    parse = OptionParser.parse(argv, switches: [help: :boolean])
    case parse do
      {[help: true], _________________________, _} -> {:help}
      {[shift: shift], ["encrypt", msg], _} -> {:encrypt, msg, shift |> String.to_integer}
      ______________________ -> {:help}
    end
  end

  def process({:encrypt, msg, shift}) do
    Caesar.Cipher.encrypt(msg, shift)
      |> IO.puts
  end

  def process({:help}) do
    IO.puts """
      usage: ./caesar <command> <message> --shift <shift_number>
    """
  end
end
