#include <vector>
#include <algorithm>
#include <iostream>
#include <unordered_set>
#include <queue>
#include <string>

using namespace std;

void PrintVector(string msg, vector<int> nums)
{
    cout << msg << " ";
    for (int num : nums)
    {
        cout << num << " ";
    }
    cout << endl;
}

class Solution
{
public:
    vector<int> largestDivisibleSubset(vector<int> &nums)
    {
        // Samllest number come first
        sort(nums.begin(), nums.end());

        vector<int> largestSet;
        vector<int> wipSet;
        largestDivisibleSubsetInternal(nums, /* startIndex= */ 0, wipSet, largestSet);

        return largestSet;
    }

private:
    void largestDivisibleSubsetInternal(
        vector<int> &nums, int startIndex, vector<int> &wipSet, vector<int> &largestSet)
    {

        if (startIndex >= nums.size())
        {
            if (wipSet.size() > largestSet.size())
            {
                largestSet = wipSet; // COPY
                return;
            }
        }

        // Find the next number to put into wipSet
        for (int i = startIndex; i < nums.size(); i++)
        {
            if (wipSet.size() == 0)
            {
                wipSet.push_back(nums[i]);
                largestDivisibleSubsetInternal(nums, i + 1, wipSet, largestSet);
                wipSet.pop_back();
            }
            else if (nums[i] % wipSet.back() == 0)
            {
                wipSet.push_back(nums[i]);
                largestDivisibleSubsetInternal(nums, i + 1, wipSet, largestSet);
                wipSet.pop_back();
            }
        }

        if (wipSet.size() > largestSet.size())
        {
            largestSet = wipSet; // COPY
        }
    }
};

vector<int> makeInput()
{
    return vector<int>{2, 3, 4, 9, 8};
}

vector<int> makeInput2()
{
    return vector<int>{1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 134217728, 268435456, 536870912, 1073741824};
}

int main()
{
    Solution s;
    auto input = makeInput2();
    vector<int> nums = s.largestDivisibleSubset(input);
    for (int num : nums)
    {
        cout << num << " ";
    }
    cout << endl;
}