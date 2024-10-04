-module(amicable_tail_recursion).

-export([sum_of_amicable_numbers/1]).

sum_of_amicable_numbers(N) ->
    sum_of_amicable_numbers(N, 1, 0).

sum_of_amicable_numbers(N, A, Acc) when N =< A ->
    Acc;
sum_of_amicable_numbers(N, A, Acc) ->
    B = sum_of_proper_divisors(A),
    DB = sum_of_proper_divisors(B),
    IsAmicable = A == DB andalso A =/= B,
    case IsAmicable of
        true ->
            sum_of_amicable_numbers(N, A + 1, Acc + A);
        false ->
            sum_of_amicable_numbers(N, A + 1, Acc)
    end.

sum_of_proper_divisors(N) ->
    sum_of_proper_divisors(N, 1, 0).

sum_of_proper_divisors(N, Curr, Acc) when N / 2 < Curr ->
    Acc;
sum_of_proper_divisors(N, Curr, Acc) when N rem Curr == 0 ->
    sum_of_proper_divisors(N, Curr + 1, Acc + Curr);
sum_of_proper_divisors(N, Curr, Acc) ->
    sum_of_proper_divisors(N, Curr + 1, Acc).
