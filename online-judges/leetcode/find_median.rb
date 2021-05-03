require 'benchmark'

class MedianFinder
  def initialize
    @large = PQueue.new { |a, b| a < b } # MinHeap
    @small = PQueue.new { |a, b| a > b } # MaxHeap
  end

  def add_num(num)
    @large << num
    @small << @large.pop

    # make sure the the size diff btw @large and @small is no greater than 1
    @large << @small.pop if @small.size > @large.size
    # puts "@large = #{@large.inspect} @small = #{@small.inspect}"
  end

  def find_median
    if @large.size == @small.size
      (@large.top + @small.top) * 1.0 / 2
    else
      @large.top
    end
  end
end

class PQueue
  attr_reader :que, :cmp

  def initialize(&block)
    @que = [nil]
    @cmp = block
  end

  def size
    @que.size - 1
  end

  def <<(v)
    @que << v

    i = @que.size - 1
    while !@que[i/2].nil? && !@cmp.call(@que[i/2], @que[i])
      heapify(@que, i / 2)
      i /= 2
    end

    self
  end

  def pop
    return nil if empty?

    # @que has at least two element (e.g. [nil, 1], [nil, 3,2,1])
    swap(@que, 1, @que.size - 1)
    ans = @que.pop
    heapify(@que, 1)

    ans
  end

  def top
    empty? ? nil : @que[1]
  end

  def empty?
    size == 0
  end

  def inspect
    "<pq: size=#{size}, top=#{top || 'nil'}>"
  end

  private

  def heapify(queue, i)

    return if i > @que.size/2

    max_i   = i
    left_i  = i * 2
    right_i = left_i + 1

    if !queue[left_i].nil? && !@cmp.call(queue[max_i], queue[left_i])
      max_i = left_i
    end

    if !queue[right_i].nil? && !@cmp.call(queue[max_i], queue[right_i])
      max_i = right_i
    end

    if max_i != i
      swap(queue, i, max_i)
      heapify(queue, max_i)
    end
  end

  def swap(arr, i1, i2)
    tmp = arr[i1]
    arr[i1] = arr[i2]
    arr[i2] = tmp
  end
end

mf = MedianFinder.new
mf.add_num(2)
mf.add_num(3)
puts mf.find_median
