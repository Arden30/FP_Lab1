-module(primes_infinite_list_with_process).

-export([sum_of_primes/1]).

sum_of_primes(N) ->
  sum_of_primes(spawn(fun() -> generate_seq(2) end), 0, N).

sum_of_primes(NextGenerator, Sum, N) ->
  NextGenerator ! {next, self()},
  receive
    Num ->
      IsPrime = is_prime(Num),
      if
        Num >= N -> Sum;
        IsPrime -> sum_of_primes(NextGenerator, Sum + Num, N);
        true -> sum_of_primes(NextGenerator, Sum, N)
      end
  end.

generate_seq(Start) ->
  receive
    {next, Pid} ->
      Pid ! Start,
      generate_seq(Start + 1)
  end.

is_prime(2) -> true;
is_prime(N) -> is_prime(N, 2).
is_prime(N, Div) when N rem Div == 0 -> false;
is_prime(N, Div) when Div * Div > N -> true;
is_prime(N, Div) -> is_prime(N, Div + 1).