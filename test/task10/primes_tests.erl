-module(primes_tests).
-include_lib("eunit/include/eunit.hrl").

primes_recursion1_test() ->
  ?assertEqual(primes_recursion:sum_of_primes(10), 17).

primes_recursion2_test() ->
  ?assertEqual(primes_recursion:sum_of_primes(2000000), 142913828922).

primes_tail_recursion1_test() ->
  ?assertEqual(primes_tail_recursion:sum_of_primes(10), 17).

primes_tail_recursion2_test() ->
  ?assertEqual(primes_tail_recursion:sum_of_primes(2000000), 142913828922).

primes_seq_filter_fold1_test() ->
  ?assertEqual(primes_seq_filter_fold:sum_of_primes(10), 17).

primes_seq_filter_fold2_test() ->
  ?assertEqual(primes_seq_filter_fold:sum_of_primes(2000000), 142913828922).

primes_map1_test() ->
  ?assertEqual(primes_seq_filter_fold:sum_of_primes(10), 17).

primes_map2_test() ->
  ?assertEqual(primes_seq_filter_fold:sum_of_primes(2000000), 142913828922).

primes_process1_test() ->
  ?assertEqual(primes_infinite_list_with_process:sum_of_primes(10), 17).

primes_process2_test() ->
  ?assertEqual(primes_infinite_list_with_process:sum_of_primes(2000000), 142913828922).
