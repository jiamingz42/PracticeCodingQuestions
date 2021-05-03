require 'benchmark/ips'

Benchmark.ips do |x|
  
  array = (1..10000).to_a

  x.report("#size") do
    10.times do
      array.size
    end
  end

  x.report("var") do 
    size = array.size
    10.times do
      size
    end
    
  end

  x.compare!
end
