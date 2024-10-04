-module(amicable_tests).
-include_lib("eunit/include/eunit.hrl").

amicable_recursion_1_test() ->
  ?assertEqual(amicable_recursion:sum_of_amicable_numbers(500), 504).

amicable_recursion_2_test() ->
  ?assertEqual(amicable_recursion:sum_of_amicable_numbers(10000), 31626).

amicable_tail_recursion_1_test() ->
  ?assertEqual(amicable_tail_recursion:sum_of_amicable_numbers(500), 504).

amicable_tail_recursion_2_test() ->
  ?assertEqual(amicable_tail_recursion:sum_of_amicable_numbers(10000), 31626).

amicable_seq_filter_fold_1_test() ->
  ?assertEqual(amicable_seq_filter_fold:sum_of_amicable_numbers(500), 504).

amicable_seq_filter_fold_2_test() ->
  ?assertEqual(amicable_seq_filter_fold:sum_of_amicable_numbers(10000), 31626).

amicable_map_1_test() ->
  ?assertEqual(amicable_map:sum_of_amicable_numbers(500), 504).

amicable_map_2_test() ->
  ?assertEqual(amicable_map:sum_of_amicable_numbers(10000), 31626).

amicable_process_1_test() ->
  ?assertEqual(amicable_infinite_list_with_process:sum_of_amicable_numbers(500), 504).

amicable_process_2_test() ->
  ?assertEqual(amicable_infinite_list_with_process:sum_of_amicable_numbers(10000), 31626).