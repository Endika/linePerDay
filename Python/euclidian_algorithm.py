# -*- coding: utf-8 -*-

euclidian = lambda x, y: x if y == 0 else euclidian(y, x % y)
print(euclidian(1112, 695))
