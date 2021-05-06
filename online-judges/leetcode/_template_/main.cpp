#include <vector>
#include <algorithm>
#include <iostream>
#include <cstdint>

using namespace std;

class Solution {
public:
    int jump(vector<int>& nums) {
        if (nums.size() == 0) {
            return nums.size();
        }

        vector<int> dp(nums.size(), INT_MAX);
        dp[0] = 0;

        for (unsigned long i = 1; i < nums.size(); i++) {
            for (int j = 0; j < i; j++) {
                if (i - j <= nums[j]) {
                    dp[i] = min(dp[i], dp[j]+1);
                }
            }
        }
        return dp[nums.size()-1];
    }
};

int main()
{
    Solution s;

    vector<int> input1 = {2,3,1,1,4};
    int res = s.jump(input1);

    cout << res << endl;

    vector<int> input2 = {2,3,0,1,4};
    res = s.jump(input1);
    cout << res << endl;
}

