#include <vector>
#include <algorithm>
#include <iostream>
#include <unordered_set>
#include <queue>

using namespace std;

/**
 * Runtime: 1252ms (Beat 16.42%)
 * Memory Usage: 266.1MB (Beat 18.87%)
 */
class Solution
{
public:
    int scheduleCourse(vector<vector<int>> &courses)
    {
        // Let's implement a brute-force solution

        // Q: Is it ok to sort in place? - We can make a shalow-copy
        sort(courses.begin(), courses.end(),
             [](vector<int> lhs, vector<int> rhs) { return lhs[1] < rhs[1]; });

        int n = courses.size();
        
        // pair<duration, index>
        std::priority_queue<pair<int, int>> takens;

        int totalTime = 0;
        for (int i = 0; i < n; i++) {
            int duration = courses[i][0];
            int lastDay = courses[i][1];
            
            if (totalTime + duration <= lastDay) {
                // NOTE: This makes a copy - can change to vector<int>
                totalTime += duration;
                takens.push(make_pair(duration, i));
                continue;
            }
            
            if (takens.size() == 0) {
                continue;
            }

            // Swap the current course with the longest courses
            if (takens.top().first > duration) {
                totalTime += duration - takens.top().first;
                takens.pop();
                takens.push(make_pair(duration, i));
            }
        }
        return takens.size();
    }
};


vector<vector<int>> makeInput()
{
    return vector<vector<int>> {{7,16},{2,3},{3,12},{3,14},{10,19},{10,16},{6,8},{6,11},{3,13},{6,16}};
}

int main()
{
    Solution s;
    vector<vector<int>> courses = makeInput();
    int res = s.scheduleCourse(courses);
    printf("res = %d", res);
}