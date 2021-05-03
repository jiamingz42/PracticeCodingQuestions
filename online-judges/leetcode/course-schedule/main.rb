require 'set'
require "minitest/autorun"
require 'logger'
require 'pry'


module Solution
  extend self

  def logger
    @logger ||= Logger.new(STDOUT)
  end

  def can_finish(num_courses, prerequisites)
    indegree = Hash.new { |hash, key| hash[key] = Set.new }
    edges = Hash.new { |hash, key| hash[key] = Set.new }
    prerequisites.each do |parent, child|
        indegree[child].add parent
        edges[parent].add child
    end

    self.logger.debug("indegree: #{indegree}")
    self.logger.debug("edges: #{edges}")

		queue = (0...num_courses).select { |node| indegree[node].size == 0 }
    self.logger.debug("queue: #{queue}")

    counter = 0
    while not queue.empty? do
      self.logger.debug("while loop: queue: #{queue}")
      curr_node = queue.shift
      counter += 1
      self.logger.debug("while loop: curr_node: #{curr_node}")
      self.logger.debug("while loop: indegree: #{indegree}")
      edges[curr_node].each do |child|
        indegree[child].delete curr_node
        queue << child if indegree[child].size == 0
      end
    end

    return counter == num_courses
  end
end

class TestSolution < Minitest::Test
  def setup
  end

  def test_can_finish
    assert_equal true, Solution.can_finish(2, [[1,0]])
    assert_equal true, Solution.can_finish(10, [[5,8],[3,5],[1,9],[4,5],[0,2],[1,9],[7,8],[4,9]])
  end
end
