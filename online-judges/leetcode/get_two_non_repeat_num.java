class Solution {

  public static int[] getTwoNonRepeatNums(int[] nums) {

      // x and y are the two non-repeat numbers, who get init to 0
      int x = 0, y = 0, xor = 0;

      // here, xor = x ^ y, assume x and y are the two non-repeat nums
      for ( int num : nums ) { xor ^= num; }
      
      int bit_mask = getRightmostBit(xor);

      for ( int num : nums ) {
          if ( (bit_mask & num) == 0 ) {
              x ^= num;
          } else {
              y ^= num;
          }
      }

      return new int[] { x, y };
  }

  // getRightmostBit(0b1010) => 0b0010
  // getRightmostBit(0b1011) => 0b0001
  public static int getRightmostBit(int num) {
    return num & ~(num-1);
  }

}
