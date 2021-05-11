#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <deque>
#include <sstream>
#include <string>
#include "./helper.h"

using namespace std;

class Solution
{
public:
    string removeDuplicateLetters(string s)
    {
        unordered_set<char> seen;
        seen.reserve(26);

        deque<int> lastPositions;

        for (int i = s.size() - 1; i >= 0; i--)
        {
            char ch = s[i];
            // Ensures both seen.count(...) and seen.insert(...) are operating on `ch`
            if (!seen.count(ch))
            {
                lastPositions.push_front(i);
                seen.insert(ch);
            }
        }

        ostringstream oss;
        unordered_set<char> added;
        seen.reserve(26);

        int start = 0;
        while (!lastPositions.empty())
        {
            int smallest_char_i = start;
            for (int i = start + 1; i <= lastPositions.front(); i++)
            {
                if (added.count(s[i]))
                {
                    continue;
                }
                if (s[i] < s[smallest_char_i])
                {
                    smallest_char_i = i;
                }
            }

            // NOTE: Easy to miss this check. This guard against the case where [start, end] contains only one char which are already seen.
            char smallest_char = s[smallest_char_i];
            if (!added.count(smallest_char))
            {
                oss << smallest_char;
                added.insert(smallest_char);
            }

            start = smallest_char_i + 1;

            while (!lastPositions.empty() && added.count(s[lastPositions.front()]))
            {
                lastPositions.pop_front();
            }
        }

        return oss.str();
    }
};

int main()
{
    //    *** *
    // 01234567
    // cdadabcc
    //   ^^-
    Solution s;
    string ans = s.removeDuplicateLetters(
        "peymrzknlxtrutjiybqemquchgvtmmtpjvunvekszrkatctcirxwuqknrycpdtcuadblzkkleduezgspoxhhssoipbmdgrqggpfdsanolzczpaggwxrlaleaqtnzxclmxwjucnujsptnbmmjzzjhypnlsoxjveywsufegzlfnyvkcnfevkshbckfropoydkdlblppllgefagjgpajsplvxknvtlgtjyhmnwxcpjjzcizihycvsnhnnmqohivekitxzuo");
    cout << "ans = " << ans << endl;
}