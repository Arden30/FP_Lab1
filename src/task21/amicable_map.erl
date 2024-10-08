-module(amicable_map).

-export([sum_of_amicable_numbers/1]).

sum_of_amicable_numbers(N) ->
    lists:sum(
        lists:map(fun(A) ->
                     B = sum_of_proper_divisors(A),
                     DB = sum_of_proper_divisors(B),
                     IsAmicable = B =/= A andalso DB =:= A,
                     case IsAmicable of
                         true ->
                             A;
                         false ->
                             0
                     end
                  end,
                  lists:seq(1, N - 1))).

sum_of_proper_divisors(N) ->
    lists:sum(
        lists:map(fun(X) ->
                     IsDivided = N rem X == 0,
                     case IsDivided of
                         true ->
                             X;
                         false ->
                             0
                     end
                  end,
                  lists:seq(1, N div 2))).
