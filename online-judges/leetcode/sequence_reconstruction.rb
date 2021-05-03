require 'set'
require 'awesome_print'

# @param {Integer[]} org
# @param {Integer[][]} seqs
# @return {Boolean}
def sequence_reconstruction(org, seqs)
    num_of_nodes = get_num_of_nodes(seqs)
    edges = get_edges(seqs)
    
    sorted_list = []
    sortable = topo_sort(num_of_nodes, edges, sorted_list)
    ap sorted_list
    
    if not sortable or not uniq(sorted_list, edges)
        false
    else
        sorted_list == org
    end
end

def get_num_of_nodes(seqs)
    seqs.size == 0 ? 0 : seqs.map(&:max).max
end

def get_edges(seqs)
    edges = Hash.new { |hash, key| hash[key] = Set.new }
    seqs.each do |seq|
        next if seq.size < 2
        0.upto(seq.size-2) do |i|
            parent_node, child_node = seq[i], seq[i+1]
            edges[parent_node].add child_node
        end
    end
    edges
end

def uniq(sorted_list, edges)
    size = sorted_list.size
    0.upto(size-2) do |i|
        parent_node, children_node = sorted_list[i], sorted_list[i+1]
        return false if not edges[parent_node].include? children_node
    end
    return true
end

# @return sortable [Boolean]
def topo_sort(num_of_nodes, edges, sorted_list)
    visiting = Set.new
    visited  = Set.new
    1.upto(num_of_nodes) do |curr_node|
        next if visited.include? curr_node
        sortable = topo_sort_helper(curr_node, edges, sorted_list, visited, visiting)
        return false if not sortable
    end
    return true
end

# @return sortable [Boolean] 
# @note this method may mutate sorted_list, visited, visiting
def topo_sort_helper(start_node, edges, sorted_list, visited, visiting)
    stack = [start_node]
    nodes_in_stack = Set.new([start_node])
    
    while not stack.empty? do
        puts "stack: #{stack}"
        puts "nodes_in_stack: #{nodes_in_stack.to_a}"
        curr_node = stack.last
        
        visiting.add curr_node
        
        children = edges[curr_node]
        return false if children.any? { |node| visiting.include? node }
        
        unvisited_children = children.reject do |node|
          nodes_in_stack.include? node or visited.include? node
        end
        if unvisited_children.empty?
            visiting.delete curr_node
            visited.add curr_node
            nodes_in_stack.delete curr_node
            sorted_list.unshift curr_node
            stack.pop
        else
            stack.concat(unvisited_children)
            nodes_in_stack.merge(unvisited_children)
        end
    end
    return true
end

puts sequence_reconstruction([1,4,2,3], [[1,2],[1,3],[2,3],[4,2],[1,4]])


