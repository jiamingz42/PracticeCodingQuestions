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

int main()
{
    Solution s;
    auto input = makeInput();
    vector<int> nums = s.largestDivisibleSubset(input);
    for (int num : nums)
    {
        cout << num << " ";
    }
    cout << endl;
}