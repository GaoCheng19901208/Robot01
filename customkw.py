#coding=utf-8
import sys
from robot.utils.asserts import assert_equal

# class customkw(object):

#     ROBOT_LIBRARY_VERSION = 1.0

#     def __init__(self):
#         pass

#     def keyword(self):
#         pass

def dir(arg, *args, **kwargs):
    print(arg, args, kwargs)

def dir2(arg, b, c):
    print(arg, b, c)

def dir3(a, b, c):
    print(a, b, c)

def should_greater_than(a, b):
    assert_equal(a > b, True, 'Invalid')

def showlist():
   a=3
   if a==2:
       return 'OK'

if __name__ == '__main__':
    print(showlist())
    nolist = [5,6,7]
    for i in nolist:
        print(i)
    dir3(b = 3, a=4, c=5)
    if sys.modules.__contains__('robot.utils.asserts'):
        print(sys.modules['robot.utils.asserts'])
    dir(1, *(2,3,4), **{'a':1, 'b':2})
    dir(1, 2, 3, 4, a=1, b=2)
    dir2(2, *(4, 5))
    dir2(2, **{'b':1, 'c':3})

