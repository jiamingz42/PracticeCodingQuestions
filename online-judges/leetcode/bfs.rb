

# s = graph tranverse starting point

levels = { s: 0 }
parents = { s: nil }

i = 1
frontier = [:s]
while frontier.empty? do
  next_frontier = []

  frontier.each do |vertex|
    adjacent_vertexes(vertex).each do |adj_vertex|
      
    end
  end

  i += 1
  frontier = next_frontier
end
