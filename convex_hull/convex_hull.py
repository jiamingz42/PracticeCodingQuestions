from math import sqrt


def convex_hull(points):
    if len(points) <= 2:
        return points

    # copy and remove duplicate
    points = list(set(points))

    x0, y0 = min(points, key=lambda (x,y): y)

    points.remove((x0, y0))

    # sorted by polar angle with regard to point (x0, y0)
    points = sorted(points, key=lambda (x,y): -cos((x-x0, y-y0), (1,0)))

    boundary = [(x0,y0), points.pop(0)]
    for point in points:
        while ccw(boundary[-2], boundary[-1], point) < 0:
            boundary.pop()
        boundary.append(point)

    return boundary


def cos(vector1, vector2):
    dot_product = vector1[0] * vector2[0] + vector1[1] * vector2[1]
    return dot_product / vector_len(*vector1) / vector_len(*vector2)


def vector_len(x, y):
    return sqrt(x**2 + y**2)


def ccw(point_a, point_b, point_c):
    ax, ay = point_a
    bx, by = point_b
    cx, cy = point_c
    area = (bx-ax) * (cy-ay) - (by-ay) * (cx-ax)
    if area < 0:
        return -1  # clockwise
    elif area > 0:
        return 1  # counter-clockwise
    else:
        return 0  # collinear
