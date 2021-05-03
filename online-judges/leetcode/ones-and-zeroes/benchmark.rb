require 'benchmark/ips'

def find_max_form(strs, m, n)
    solutions = (m+1).times.map { [0] * (n+1) }
    
    strs.each do |str|
       count = { '0' => str.count('0'), '1' => str.count('1') }
       m.downto(count['0']).each do |available_zero|
           n.downto(count['1']).each do |available_one|
                solutions[available_zero][available_one] = [
                    solutions[available_zero][available_one],
                    solutions[available_zero-count['0']][available_one-count['1']] + 1
                ].max  
           end
       end
    end
    
    solutions[m][n]
end

def find_max_form2(strs, m, n)
    solutions = (m+1).times.map { [0] * (n+1) }
    
    strs.each do |str|
       zero_count = str.count('0')
       one_count = str.count('1')
       m.downto(zero_count).each do |available_zero|
           n.downto(one_count).each do |available_one|
                solutions[available_zero][available_one] = [
                    solutions[available_zero][available_one],
                    solutions[available_zero-zero_count][available_one-one_count] + 1
                ].max  
           end
       end
    end
    
    solutions[m][n]
end

strs = [
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01","11","01","11","01",
  "11","01","11","01","11","01"
]

Benchmark.ips do |x|
  x.config(:time => 10, :warmup => 10)

  x.report("find_max_form") do
   find_max_form(strs, 50, 50)
  end

  x.report("find_max_form2") do 
   find_max_form2(strs, 50, 50)
  end

  x.compare!
end
