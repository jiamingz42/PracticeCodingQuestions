#include <vector>
#include <algorithm>
#include <iostream>
#include <unordered_set>

using namespace std;

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
        
        unordered_set<int> takens;

        int totalTime = 0;
        for (int i = 0; i < n; i++) {
            int duration = courses[i][0];
            int lastDay = courses[i][1];
            
            if (totalTime + duration <= lastDay) {
                // NOTE: This makes a copy - can change to vector<int>
                totalTime += duration;
                takens.insert(i);
                continue;
            }
            
            if (takens.size() == 0) {
                continue;
            }
            
            int maxIndex = -1;
            for (int taken : takens) {
                if (maxIndex == -1) {
                    maxIndex = taken;
                    continue;
                } 
                if (courses[taken][0] > courses[maxIndex][0]) {
                    maxIndex = taken;
                }
            }
            
            // Swap the current course with the longest courses
            if (courses[maxIndex][0] > duration) {
                totalTime += duration - courses[maxIndex][0];
                takens.erase(maxIndex);
                takens.insert(i);
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