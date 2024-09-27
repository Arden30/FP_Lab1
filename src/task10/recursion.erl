-module(recursion).

%% API
-export([sum_of_primes/1]).

sum_of_primes(N) -> sum_of_primes(N, 2).

sum_of_primes(N, Curr) when Curr >= N -> 0;
sum_of_primes(N, Curr) ->
  IsPrime = is_prime(Curr),
  if
    IsPrime -> Curr + sum_of_primes(N, Curr + 1);
    true -> sum_of_primes(N, Curr + 1)
  end.

is_prime(2) -> true;
is_prime(N) -> is_prime(N, 2).

is_prime(N, Div) when N rem Div == 0 -> false;
is_prime(N, Div) when Div * Div > N -> true;
is_prime(N, Div) -> is_prime(N, Div + 1).