-module(amicable_seq_filter_fold).

-export([sum_of_amicable_numbers/1]).

sum_of_amicable_numbers(N) ->
    AmicableNumbers =
        lists:filter(fun(A) ->
                        B = sum_of_proper_divisors(A),
                        B =/= A andalso sum_of_proper_divisors(B) =:= A
                     end,
                     lists:seq(1, N - 1)),
    lists:foldl(fun(X, Acc) -> X + Acc end, 0, AmicableNumbers).

sum_of_proper_divisors(N) ->
    Divisors = lists:filter(fun(X) -> N rem X == 0 end, lists:seq(1, N div 2)),
    lists:sum(Divisors).
