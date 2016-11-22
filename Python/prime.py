# -*- coding: utf-8 -*-

is_prime = lambda x, n: is_prime(
    x, n - 1) if n > 1 and x % n != 0 else True if n == 1 else False

prime_numbers = [i for i in range(1, 100) if is_prime(i, i - 1)]
print prime_numbers
