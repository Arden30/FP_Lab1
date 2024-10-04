-module(primes_seq_filter_fold).

-export([sum_of_primes/1]).

sum_of_primes(N) ->
    List = lists:seq(2, N - 1),
    Primes = lists:filter(fun(X) -> is_prime(X) end, List),
    lists:foldl(fun(X, Acc) -> X + Acc end, 0, Primes).

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
