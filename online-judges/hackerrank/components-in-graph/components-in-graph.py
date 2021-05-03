"""
Source: https://www.hackerrank.com/challenges/components-in-graph

Date: July 23, 2017

Note: My first attempt passed most testcases but it raise 'RecursionError:
maximum recursion depth exceeded' when the testcases contains too many nodes or
union operation.

At that point, DisjointSet did not `union` two parent nodes using their
size/rank info so it may build a very tall tree, which cause `find` operation
traverse a long tree path. DisjointSet.find call itself recursive, which lead
to this error.

The RecursionError is fixed by (1) Use iteration rather than recursion in
`find` method as Python does not support tail recursive. (2) Improve `union`
method to consider size when joining two sets.

The second submission caused a few Timeout errors. This is mysterious as the
time complexitity should be log(N). Then, I found the `find` method is called a
few millions times when there are only 10k union operation. This was caused by
a parallel assignment in the `find` method, something like

```python
child, self._parents[child] = self.parents[child], self._parents[self._parents[child]]`
```

This was intended to do a path compression. However, I misunderstood what's the
evaluation order of this statement. This statement happened to not update
anything.

"""

from collections import defaultdict

def main():

    vertices = set()
    djset = DisjointSet()

    n = _next_int()
    for _ in range(n):
      i, j = _next_edge()
      vertices.update({i,j})
      djset.union(i, j)

    counter = defaultdict(int)
    for v in vertices:
        parent = djset.find(v)
        counter[parent] += 1

    djset.find(6)

    values = counter.values()
    print("%d %d" % (min(values), max(values)))


def _next_int():
    return int(input())


def _next_edge():
    return [int(x) for x in input().split(" ")]


class DisjointSet(object):
    def __init__(self):
        self._sizes = defaultdict(lambda : 1)
        self._parents = defaultdict(lambda : -1)

    def find(self, i):
        # Lazily init a vertex's parent
        if self._parents[i] == -1:
            self._parents[i] = i

        # Avoid mutating input parameter
        child = i
        while child != self._parents[child]:
            # child now link directly to its grandparent
            self._parents[child] = self._parents[self._parents[child]]
            child = self._parents[child]

        return child


    def union(self, i, j):
        i_parent = self.find(i)
        j_parent = self.find(j)

        if i_parent == j_parent:
            return

        if self._sizes[i_parent] < self._sizes[j_parent]:
            self._parents[i_parent] = j_parent
        else:
            # Cautious!
            #   Not `self._parents[j] = i_parent`
            #   This statement set j's parent a child of i's parent
            self._parents[j_parent] = i_parent


main()
