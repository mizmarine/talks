# -*- coding: utf-8 -*-


def fib(x):
    a_1, a_2 = 1, 1

    if x == 1:
        return a_1
    if x == 2:
        return a_2

    v = 0
    i = 2
    while i < x:
        i += 1
        v = a_1 + a_2
        a_1 = a_2
        a_2 = v
    return v


if __name__ == '__main__':
    print fib(1)
    print fib(2)
    print fib(3)
    print fib(4)
    print fib(5)
    print fib(6)
