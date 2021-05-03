# psuedo code for death first search

def dfs(vertex, parents = {})
  parents[vertext] = nil if parents.empty?

  adjacent_vertexes(vertext).each do |adj_vertext|
    if !parents.include?(adj_vertext)
      parents[adj_vertext]= vertext
      dfs(adj_vertext, parents)
    end
  end
  
end
