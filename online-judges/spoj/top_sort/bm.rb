require 'benchmark/ips'

Benchmark.ips do |x|

  input = "123 123"

  x.report("regex") do
    matches = /(\d+) (\d+)/.match(input)
    x = input[1].to_i
    y = input[2].to_i
  end

  x.report("split") do 
    x, y = input.split(" ").map(&:to_i)
  end

  x.compare!
end
