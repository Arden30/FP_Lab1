-module(amicable_tests).

-include_lib("eunit/include/eunit.hrl").

amicable_recursion1_test() ->
    ?assertEqual(amicable_recursion:sum_of_amicable_numbers(500), 504).

amicable_recursion2_test() ->
    ?assertEqual(amicable_recursion:sum_of_amicable_numbers(10000), 31626).

amicable_tail_recursion1_test() ->
    ?assertEqual(amicable_tail_recursion:sum_of_amicable_numbers(500), 504).

amicable_tail_recursion2_test() ->
    ?assertEqual(amicable_tail_recursion:sum_of_amicable_numbers(10000), 31626).

amicable_seq_filter_fold1_test() ->
    ?assertEqual(amicable_seq_filter_fold:sum_of_amicable_numbers(500), 504).

amicable_seq_filter_fold2_test() ->
    ?assertEqual(amicable_seq_filter_fold:sum_of_amicable_numbers(10000), 31626).

amicable_map1_test() ->
    ?assertEqual(amicable_map:sum_of_amicable_numbers(500), 504).

amicable_map2_test() ->
    ?assertEqual(amicable_map:sum_of_amicable_numbers(10000), 31626).

amicable_process1_test() ->
    ?assertEqual(amicable_infinite_list_with_process:sum_of_amicable_numbers(500), 504).

amicable_process2_test() ->
    ?assertEqual(amicable_infinite_list_with_process:sum_of_amicable_numbers(10000), 31626).
