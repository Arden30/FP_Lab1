-module(amicable_map).

-export([sum_of_amicable_numbers/1]).

sum_of_amicable_numbers(N) ->
  lists:sum(
    lists:map(fun(A) ->
      B = sum_of_proper_divisors(A),
      D_B = sum_of_proper_divisors(B),
        if
          B =/= A andalso D_B =:= A -> A;
          true -> 0
        end
      end,
      lists:seq(1, N - 1)
    )
  ).

sum_of_proper_divisors(N) ->
  Divisors = lists:filter(fun(X) -> N rem X == 0 end, lists:seq(1, N div 2)),
  lists:sum(Divisors).