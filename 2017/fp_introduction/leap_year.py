# -*- coding: utf-8 -*-


def is_leap_year_naive(n):
    if n % 4 == 0:
        if n % 100 == 0:
            if n % 400 == 0:
                return True
            else:
                return False
        else:
            return True
    else:
        return False


def is_leap_year_fast_return(n):
    if n % 400 == 0:
        return True

    if n % 100 == 0:
        return False

    if n % 4 == 0:
        return True

    return False
