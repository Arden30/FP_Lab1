-module(primes_map).

-export([sum_of_primes/1]).

sum_of_primes(N) ->
    lists:sum(
        lists:map(fun(X) ->
                     IsPrime = is_prime(X),
                     case IsPrime of
                         true ->
                             X;
                         false ->
                             0
                     end
                  end,
                  lists:seq(2, N - 1))).

is_prime(2) ->
    true;
is_prime(N) ->
    is_prime(N, 2).

is_prime(N, Div) when N rem Div == 0 ->
    false;
is_prime(N, Div) when Div * Div > N ->
    true;
is_prime(N, Div) ->
    is_prime(N, Div + 1).
