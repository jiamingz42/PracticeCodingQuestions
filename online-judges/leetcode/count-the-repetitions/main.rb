require 'awesome_print'
# https://leetcode.com/contest/leetcode-weekly-contest-11/problems/count-the-repetitions/

# @param {String} s1
# @param {Integer} n1
# @param {String} s2
# @param {Integer} n2
# @return {Integer}
def get_max_repetitions(s1, n1, s2, n2)
  # TODO: edge case "", 0
  count = get_max_repetitions_helper(s1, n1, s2)
  count / n2
end

def get_max_repetitions_helper(s1, n1, s2)
  p2 = 0
  positions = []

  (0...s1.size*n1).each do |p1|
      # Give up when no char when can be matched w/ a full cyle
      cycle = p1 / s1.size
      return 0 if positions.size < cycle    

      c1, c2 = s1[p1 % s1.size], s2[p2 % s2.size]
      if c1 == c2
        positions[p2] = p1
        # puts positions.each_with_index.map { |k,i| "(#{i}, #{k})" }.join(", ")

        (p2-s2.size).step(0, -s2.size) do |i|
          # Found pair (i, positions[i]) and (p2, positions[p2])
          # where (p2-i) % s2.size == 0 and
          #       (positions[p2] - positions[i]) % s1.size == 0
          if (p1 - positions[i]) % s1.size == 0
            # puts "Found pairs (#{i}, #{positions[i]}), (#{p2}, #{positions[p2]})"
            parts = [
              (positions.size-1),
              (s1.size*n1-p1) / (positions[p2] - positions[i]) * (p2-i),
              # How many extra s2 char can we match if
              # if move p1 from [positions[i], positions[i+remain])
              positions[i..-1].select do |k|
                #   [ -------- remaining step for s1 -----------   ]
                k <= (s1.size*n1-p1) % (positions[p2] - positions[i]) + positions[i] - 1
              end.size
            ]
            # puts "parts: #{parts.join(', ')}"
            num_of_chars = parts.reduce(&:+)
            return num_of_chars / s2.size
          end
          i -= s2.size
        end
        
        p2 += 1
      end
  end

  positions.size / s2.size
end
