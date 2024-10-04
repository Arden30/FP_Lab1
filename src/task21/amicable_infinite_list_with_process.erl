-module(amicable_infinite_list_with_process).

-export([sum_of_amicable_numbers/1]).

sum_of_amicable_numbers(N) ->
    sum_of_amicable_numbers(spawn(fun() -> generate_seq(2) end), 0, N).

sum_of_amicable_numbers(NextGenerator, Sum, N) ->
    NextGenerator ! {next, self()},
    receive
        Num ->
            IsAmicable = is_amicable(Num),
            case {Num >= N, IsAmicable} of
                {true, _} ->
                    Sum;
                {true, true} ->
                    sum_of_amicable_numbers(NextGenerator, Sum + Num, N);
                {true, false} ->
                    sum_of_amicable_numbers(NextGenerator, Sum, N)
            end
    end.

is_amicable(A) ->
    B = sum_of_proper_divisors(A),
    B =/= A andalso sum_of_proper_divisors(B) =:= A.

sum_of_proper_divisors(N) ->
    Divisors = lists:filter(fun(X) -> N rem X == 0 end, lists:seq(1, N div 2)),
    lists:sum(Divisors).

generate_seq(Start) ->
    receive
        {next, Pid} ->
            Pid ! Start,
            generate_seq(Start + 1)
    end.
