#include <vector>
#include <algorithm>
#include <iostream>

using namespace std;

// TODO: Solution 

int main()
{
    Solution s;
    vector<vector<int>> courses = makeInput();
    int res = s.scheduleCourse(courses);
    printf("res = %d", res);
}

