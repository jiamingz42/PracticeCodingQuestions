# https://leetcode.com/contest/leetcode-weekly-contest-11/problems/convex-polygon/

# @param {Integer[][]} points
# @return {Boolean}
def is_convex(points)
  return true if points.size == 3

  size = points.size
  0.upto(size-1).all? do |i|
    line_edge_a = points[i % size]
    line_edge_b = points[(i+2) % size]
    point_a = points[(i+1) % size]
    point_b = points[(i+3) % size]

    are_points_on_different_side_of_the_line(
      line_edge_a, line_edge_b,
      point_a, point_b,
    )
  end
end

def are_points_on_different_side_of_the_line(line_edge_a, line_edge_b, point1, point2)
  func = get_line_func(line_edge_a, line_edge_b) 
  if func.call(0).nil?
    vertical_line_x = line_edge_a[0] 
    (point1[0]-vertical_line_x) * (point2[0]-vertical_line_x)
  else
    x1, y1 = point1
    x2, y2 = point2
    (func.call(x1) - y1) * (func.call(x2) - y2) < 0
  end
end

def get_line_func(point1, point2)
  slope = get_line_slope(point1, point2)
  intercept = \
    if slope.nil?
      nil
  else
    - slope * point1[0] + point1[1]
  end

  func = Proc.new do |x|
    if slope.nil?
      nil
    else
      slope * x + intercept
    end
  end
end

def get_line_slope(point1, point2)
  x1, y1 = point1
  x2, y2 = point2
  x1 == x2 ? nil : (y1-y2)*1.0/(x1-x2)
end
