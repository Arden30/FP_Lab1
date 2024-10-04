-module(amicable_recursion).

-export([sum_of_amicable_numbers/1]).

sum_of_amicable_numbers(N) ->
    sum_of_amicable_numbers(N, 1).

sum_of_amicable_numbers(N, A) when N =< A ->
    0;
sum_of_amicable_numbers(N, A) ->
    B = sum_of_proper_divisors(A),
    DB = sum_of_proper_divisors(B),
    IsAmicable = A == DB,
    A =/= B,
    case IsAmicable of
        true ->
            A + sum_of_amicable_numbers(N, A + 1);
        false ->
            sum_of_amicable_numbers(N, A + 1)
    end.

sum_of_proper_divisors(N) ->
    sum_of_proper_divisors(N, 1).

sum_of_proper_divisors(N, Curr) when N / 2 < Curr ->
    0;
sum_of_proper_divisors(N, Curr) when N rem Curr == 0 ->
    Curr + sum_of_proper_divisors(N, Curr + 1);
sum_of_proper_divisors(N, Curr) ->
    sum_of_proper_divisors(N, Curr + 1).
