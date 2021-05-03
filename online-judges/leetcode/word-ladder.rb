# https://leetcode.com/problems/word-ladder/
require('set')

def ladder_length(begin_word, end_word, word_list)

    len = 1 # keep of how many steps

    begin_set = Set.new([begin_word])
    end_set = Set.new([end_word])

    word_list = Set.new(word_list)
    visited = Set.new

    while (!begin_set.empty? && !end_set.empty?) do

      tmp = Set.new

      if begin_set.size > end_set.size
        begin_set, end_set = end_set, begin_set
      end

      begin_set.each do |word|
        next_valid_mutation_words(word).each do |mutated_word|

          return len+1 if end_set.include?(mutated_word) # found!

          if word_list.include?(mutated_word) &&
             !visited.include?(mutated_word)
             tmp << mutated_word
             visited << mutated_word
          end
        end
      end

      begin_set = tmp
      len += 1
    end

    return 0
end

def next_valid_mutation_words(word)
  mututated_words = []

  0.upto(word.size-1) do |i|
    ('a'..'z').each do |char|
      next if word[i] == char
      mututated_word = word.dup
      mututated_word[i] = char
      mututated_words << mututated_word
    end
  end
  mututated_words
end

puts ladder_length('hit', 'dog', ["hot","dot","dog","lot","log"]) #=> 5

# Test case
# 1: what if no such a path
# 2:


def ladder_length(begin_word, end_word, word_list)

    len = 1 # keep of how many steps

    # Init begin_set, end_set, word_list and visited

    while (!begin_set.empty? && !end_set.empty?) do

      tmp = Set.new

      if begin_set.size > end_set.size
        begin_set, end_set = end_set, begin_set
      end

      begin_set.each do |word|
        next_valid_mutation_words(word).each do |new_word|

          return len+1 if end_set.include?(new_word) # found!

          if word_list.include?(new_word) && !visited.include?(new_word)
             tmp << new_word
             visited << new_word
          end
        end
      end

      begin_set, len = tmp, len+1
    end

    return 0
end

# Generate possible mutation of the given word
# next_valid_mutation_words('at') => ['bt', 'ct', ...]
def next_valid_mutation_words(word)
  # [..Omited..]
end
