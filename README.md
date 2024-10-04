![Linter/Tests](https://github.com/Arden30/FP_Lab1/actions/workflows/fp_lab1.yaml/badge.svg)

# Функциональное программирование. Лабораторная работа №1

## Выполнил: `Арсеньев Денис, группа P3314`

## Язык: `Erlang`. Вариант: 10, 21

Цель: освоить базовые приёмы и абстракции функционального программирования: функции, поток управления и поток данных,
сопоставление с образцом, рекурсия, свёртка, отображение, работа с функциями как с данными, списки.

В рамках лабораторной работы вам предлагается решить несколько задач [проекта Эйлер](https://projecteuler.net/archives).
Список задач -- ваш вариант.

Для каждой проблемы должно быть представлено несколько решений:

1. монолитные реализации с использованием:
    - хвостовой рекурсии;
    - рекурсии (вариант с хвостовой рекурсией не является примером рекурсии);
2. модульной реализации, где явно разделена генерация последовательности, фильтрация и свёртка (должны использоваться
   функции reduce/fold, filter и аналогичные);
3. генерация последовательности при помощи отображения (map);
4. работа со спец. синтаксисом для циклов (где применимо);
5. работа с бесконечными списками для языков, поддерживающих ленивые коллекции или итераторы как часть языка (к примеру
   Haskell, Clojure);
6. реализация на любом удобном для вас традиционном языке программирования для сравнения.

Требуется использовать идиоматичный для технологии стиль программирования.

Содержание отчёта:

- титульный лист;
- описание проблемы;
- ключевые элементы реализации с минимальными комментариями;
- выводы (отзыв об использованных приёмах программирования).

Примечания:

- необходимо понимание разницы между ленивыми коллекциями и итераторами;
- нужно знать особенности используемой технологии и того, как работают использованные вами приёмы.

## [Задача 10. Summation of Primes](https://projecteuler.net/problem=10)

The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.

### 1. Реализация с использованием рекурсии.

```erlang
sum_of_primes(N) ->
  sum_of_primes(N, 2).

sum_of_primes(N, Curr) when Curr >= N ->
  0;
sum_of_primes(N, Curr) ->
  IsPrime = is_prime(Curr),
  case IsPrime of
    true ->
      Curr + sum_of_primes(N, Curr + 1);
    false ->
      sum_of_primes(N, Curr + 1)
  end.

is_prime(2) ->
  true;
is_prime(N) ->
  is_prime(N, 2).

is_prime(N, Div) when N rem Div == 0 ->
  false;
is_prime(N, Div) when Div * Div > N ->
  true;
is_prime(N, Div) ->
  is_prime(N, Div + 1).
```

Функция `sum_of_primes` рекурсивно считает сумму чисел, фильтруя их по простоте, используя другую рекурсивную
функцию `is_prime`

### 2. Реализация с использованием хвостовой рекурсии.

```erlang
sum_of_primes(N) ->
  sum_of_primes(N, 2, 0).

sum_of_primes(N, Curr, Acc) when Curr >= N ->
  Acc;
sum_of_primes(N, Curr, Acc) ->
  IsPrime = is_prime(Curr),
  case IsPrime of
    true ->
      sum_of_primes(N, Curr + 1, Acc + Curr);
    false ->
      sum_of_primes(N, Curr + 1, Acc)
  end.

is_prime(2) ->
  true;
is_prime(N) ->
  is_prime(N, 2).

is_prime(N, Div) when N rem Div == 0 ->
  false;
is_prime(N, Div) when Div * Div > N ->
  true;
is_prime(N, Div) ->
  is_prime(N, Div + 1).
```

Функция `sum_of_primes` в хвосте накапливает полученную сумму прсотых чисел, функция `is_prime` всё также определяет
простоту числа

### 3. Реализация с использованием генерации последовательности, фильтрации и свёртки.

```erlang
sum_of_primes(N) ->
  List = lists:seq(2, N - 1),
  Primes = lists:filter(fun(X) -> is_prime(X) end, List),
  lists:foldl(fun(X, Acc) -> X + Acc end, 0, Primes).

is_prime(2) ->
  true;
is_prime(N) ->
  is_prime(N, 2).

is_prime(N, Div) when N rem Div == 0 ->
  false;
is_prime(N, Div) when Div * Div > N ->
  true;
is_prime(N, Div) ->
  is_prime(N, Div + 1).
```

Создаётся последовательность чисел от 2 до предельного значения (используется `lists:seq`), фильтруется по простосте (
используется `lists:filter`) и далее происходит свёртка последовательности простых чисел в сумму (
используется `lists:foldl`)

### 4. Реализация с использованием генерации последовательности при помощи отображения (map).

```erlang
sum_of_primes(N) ->
  lists:sum(
    lists:map(fun(X) ->
      IsPrime = is_prime(X),
      case IsPrime of
        true ->
          X;
        false ->
          0
      end
              end,
      lists:seq(2, N - 1))).

is_prime(2) ->
  true;
is_prime(N) ->
  is_prime(N, 2).

is_prime(N, Div) when N rem Div == 0 ->
  false;
is_prime(N, Div) when Div * Div > N ->
  true;
is_prime(N, Div) ->
  is_prime(N, Div + 1).
```

Отображение `lists:map` генерирует последовательность простых чисел, а `lists:sum` совершает суммирование
сгенерированной последовательности

### 5. Реализация с использованием бесконечных списков.

```erlang
sum_of_primes(N) ->
  sum_of_primes(spawn(fun() -> generate_seq(2) end), 0, N).

sum_of_primes(NextGenerator, Sum, N) ->
  NextGenerator ! {next, self()},
  receive
    Num ->
      IsPrime = is_prime(Num),
      case {Num >= N, IsPrime} of
        {true, _} ->
          Sum;
        {false, true} ->
          sum_of_primes(NextGenerator, Sum + Num, N);
        {false, false} ->
          sum_of_primes(NextGenerator, Sum, N)
      end
  end.

generate_seq(Start) ->
  receive
    {next, Pid} ->
      Pid ! Start,
      generate_seq(Start + 1)
  end.

is_prime(2) ->
  true;
is_prime(N) ->
  is_prime(N, 2).

is_prime(N, Div) when N rem Div == 0 ->
  false;
is_prime(N, Div) when Div * Div > N ->
  true;
is_prime(N, Div) ->
  is_prime(N, Div + 1).
```

В силу отсутствия бесконечных коллекций в Erlang, для иммитации процесса генерации бесконечной последовательности
используются простейшие процессы. Конкретно в данной реализацией используется генерация последовательности натуральных
чисел, которая после обрабатывается рекурсией для суммирования простых чисел

### Реализация на традиционном языке.

```Java
public class PrimesCounter {
    public static long sumOfPrimes(long n) {
        long sum = 0;
        for (int i = 2; i < n; i++) {
            if (isPrime(i)) {
                sum += i;
            }
        }

        return sum;
    }

    public static boolean isPrime(long n) {
        for (long i = 2; i <= sqrt(n); i++) {
            if (n % i == 0) {
                return false;
            }
            if (i * i > n) {
                return true;
            }
        }

        return true;
    }
}
```

В качестве традиционного языка используется `Java`, а также используется традиционный итеративный подход (с
использованием циклов, которых нет в Erlang) для перебора чисел и проверки на простоту, и накапливания суммы в одной
переменной

## [Задача 21. Amicable Numbers](https://projecteuler.net/problem=21)

Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into). If d(a) = b and
d(b) = a, where a != b, then a and b are amicable pair and each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1,2,4,5,10,11,20,22,44,55 and 110; therefore d(220) = 284. The proper
divisors of 284 are 1,2,4,71 and 142; d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.

### 1. Реализация с использованием рекурсии.

```erlang
sum_of_amicable_numbers(N) ->
  sum_of_amicable_numbers(N, 1).

sum_of_amicable_numbers(N, A) when N =< A ->
  0;
sum_of_amicable_numbers(N, A) ->
  B = sum_of_proper_divisors(A),
  DB = sum_of_proper_divisors(B),
  IsAmicable = A == DB andalso A =/= B,
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
```

Функция `sum_of_amicable_numbers` рекурсивно считает сумму чисел, определяя есть ли у текущего числа дружественная (
amicable) пара, а для подсчета собственных делителей используется рекурсивная функция `sum_of_proper_divisors`

### 2. Реализация с использованием хвостовой рекурсии.

```erlang
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
```

Функция `sum_of_amicable_numbers` в хвосте накапливает полученную сумму дружественных чисел,
функция `sum_of_proper_divisors` аналогично копит сумму делителей

### 3. Реализация с использованием генерации последовательности, фильтрации и свёртки.

```erlang
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
```

Создаётся последовательность чисел от 1 до предельного значения (используется `lists:seq`), фильтруется по наличию
дружественной пары (используется `lists:filter`) и далее происходит свёртка последовательности дружественных чисел в
сумму (используется `lists:foldl`)

### 4. Реализация с использованием генерации последовательности при помощи отображения (map).

```erlang
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

```

Отображение `lists:map` генерирует последовательность дружественных чисел, а `lists:sum` совершает суммирование
сгенерированной последовательности. Аналогично для функции поиска собственных делителей `sum_of_proper_divisors`

### 5. Реализация с использованием бесконечных списков.

```erlang
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
        {false, true} ->
          sum_of_amicable_numbers(NextGenerator, Sum + Num, N);
        {false, false} ->
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
```

В силу отсутствия бесконечных коллекций в Erlang, для иммитации процесса генерации бесконечной последовательности
используются простейшие процессы.
Конкретно в данной реализацией используется генерация последовательности натуральных чисел, которая после обрабатывается
рекурсией для суммирования дружественных чисел

### Реализация на традиционном языке.

```Java
public static long sumOfAmicableNumbers(long n) {
    long sum = 0;
    for (long a = 1; a <= n; a++) {
        long b = sumOfProperDivisors(a);
        if (sumOfProperDivisors(b) == a && a != b) {
            sum += a;
        }
    }

    return sum;
}

public static long sumOfProperDivisors(long n) {
    long sum = 0;
    for (int i = 1; i <= n / 2; i++) {
        if (n % i == 0) {
            sum += i;
        }
    }

    return sum;
}
```

В качестве традиционного языка используется `Java`, а также используется традиционный итеративный подход (с
использованием циклов, которых нет в Erlang) для перебора чисел и проверки на дружественность,
и накапливания их суммы в одной переменной

## Выводы

В ходе выполнения лабораторной работы я познакомился с базовыми приемами функциональных языков программирования на
примере Erlang.
За отсутсвием циклов пришлось поломать мозг рекурсией (оказалось несложно по итогу), было удобно применить функции
фильтрации и сверток для обработки чисел, а также отображения оказались не менее полезным свойством.
С точки зрения бесконечных списков, получилось странное решение с использованием процессов, не увидел никакой особой
пользы от этого в рамках данных задач, и вероятно, что их удобнее использовать для совершенно другого рода проблем.

В целом, данные задачи идентично решаются как итеративным подходом, так и с использованием средств ФП, при этом было
приятно в полной мере пользоваться анонимными функциями и средствами фильтрации для обработки чисел.
