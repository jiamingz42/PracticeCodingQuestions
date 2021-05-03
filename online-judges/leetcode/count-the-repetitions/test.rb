require './main'
require "minitest/autorun"

class TestCase < Minitest::Test
  # s1, n1, s2, n2, ans
  FIXTURES = [
    # S2 can be obtained from S1
    # 1) s2 can be obtained from s1
    ['acb', 4, 'ab', 2, 2],
    ['ababc', 4, 'ab', 2, 4],
    ['aaa', 3, 'aa', 2, 2],
    ['aaa', 1000000, 'aa', 5, 300000],
    ['baba', 3, 'ab', 2, 2],
    # 2) s2 cannot be obtained from one s1
    ['ababc', 4, 'cab', 2, 1],
    ['abc', 7, 'cba', 1, 3],

    # S2 cannot be obtained from S1
    ['ababc', 4, 'abd', 2, 0],
    ['abc', 2, 'ab', 3, 0],
    ['aaa', 1000000, 'cc', 5, 0],
    ['aaac', 1000000, 'cb', 5, 0],
  ]
  
  FIXTURES.each do |s1, n1, s2, n2, expect_ans|
    define_method ['test', s1, n1, s2, n2].join('_') do
      actual_ans = get_max_repetitions(s1, n1, s2, n2)
      assert_equal expect_ans, actual_ans, "get_max_repetitions(#{s1.inspect}, #{n1}, #{s2.inspect}, #{n2})"
    end
  end

  def test_foo
    assert_equal 1, 1, 'xxx'
  end
end

