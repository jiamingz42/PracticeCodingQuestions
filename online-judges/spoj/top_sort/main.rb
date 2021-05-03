# http://www.spoj.com/problems/TOPOSORT/
require 'set'

VISITING = 1
VISITED = 2

def main
  num_of_nodes, num_of_edges = gets.split(' ').map(&:to_i)

  edges = Hash.new { |hash,key| hash[key] = [] }
  num_of_edges.times do 
    parent_node, child_node = gets.split(' ').map(&:to_i)
    edges[parent_node] << child_node
  end

  sorted_list = topo_sort(num_of_nodes, edges)
  if sorted_list.nil?
    puts 'Sandro fails.'
  else
    puts sorted_list.join(' ')
  end
end

# @param num_of_nodes [Intger] (Assume range from 1 to 10,000)
# @param edges [Hash<Integer, List>] (Assume size ranges from 1 to 1,000,000)
# @return Array<Integer> or None
def topo_sort(num_of_nodes, edges)
  # Use `list` as Stack as Ruby does not has built-in Stack
  sorted_list = []
  status = {}

  num_of_nodes.downto(1) do |curr_node|
    next if status[curr_node] == VISITED
    has_cycle = topo_sort_helper(curr_node, edges, sorted_list, status)
    return nil if has_cycle
  end

  sorted_list.reverse
end

# @note this method may mute `sorted_list` and `visited`
# @return boolean
#    return true when the graph has cycle and thus cannot be topo sorted
#    return false otherwise
def topo_sort_helper(curr_node, edges, sorted_list, status)
  status[curr_node] = VISITING

  edges[curr_node].sort.reverse_each do |child_node|
    next if status[child_node] == VISITED
    return true if status[child_node] == VISITING
    has_cycle = topo_sort_helper(child_node, edges, sorted_list, status)
    return true if has_cycle
  end

  status[curr_node] = VISITED

  sorted_list << curr_node
  return false
end

main
