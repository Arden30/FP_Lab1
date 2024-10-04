-module(primes_tail_recursion).

-export([sum_of_primes/1]).

sum_of_primes(N) -> sum_of_primes(N, 2, 0).

sum_of_primes(N, Curr, Acc) when Curr >= N -> Acc;
sum_of_primes(N, Curr, Acc) ->
  IsPrime = is_prime(Curr),
  case IsPrime of
    true -> sum_of_primes(N, Curr + 1, Acc + Curr);
    false -> sum_of_primes(N, Curr + 1, Acc)
  end.

is_prime(2) -> true;
is_prime(N) -> is_prime(N, 2).
is_prime(N, Div) when N rem Div == 0 -> false;
is_prime(N, Div) when Div * Div > N -> true;
is_prime(N, Div) -> is_prime(N, Div + 1).