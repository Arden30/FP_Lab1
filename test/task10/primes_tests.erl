-module(primes_tests).
-include_lib("eunit/include/eunit.hrl").

primes_recursion_1_test() ->
  ?assertEqual(primes_recursion:sum_of_primes(10), 17).

primes_recursion_2_test() ->
  ?assertEqual(primes_recursion:sum_of_primes(2000000), 142913828922).

primes_tail_recursion_1_test() ->
  ?assertEqual(primes_tail_recursion:sum_of_primes(10), 17).

primes_tail_recursion_2_test() ->
  ?assertEqual(primes_tail_recursion:sum_of_primes(2000000), 142913828922).

primes_seq_filter_fold_1_test() ->
  ?assertEqual(primes_seq_filter_fold:sum_of_primes(10), 17).

primes_seq_filter_fold_2_test() ->
  ?assertEqual(primes_seq_filter_fold:sum_of_primes(2000000), 142913828922).

primes_map_1_test() ->
  ?assertEqual(primes_seq_filter_fold:sum_of_primes(10), 17).

primes_map_2_test() ->
  ?assertEqual(primes_seq_filter_fold:sum_of_primes(2000000), 142913828922).

primes_process_1_test() ->
  ?assertEqual(primes_infinite_list_with_process:sum_of_primes(10), 17).

primes_process_2_test() ->
  ?assertEqual(primes_infinite_list_with_process:sum_of_primes(2000000), 142913828922).
