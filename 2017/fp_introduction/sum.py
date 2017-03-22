# -*- coding: utf-8 -*-


def mysum(xs):
    v = 0
    for i in xs:
        v += i
    return v

if __name__ == '__main__':
    print mysum([1, 2, 3, 4, 5])
