#include <string>
#include <unordered_map>
#include <unordered_set>
#include <sstream>

using namespace std;

/** 
 * Incorrect Solution
 * 
 * Input: "cbacdcbc"
 * Output: "adbc"
 * Expected: "acdb"
 */
class Solution {
public:
    string removeDuplicateLetters(string s) {
        unordered_map<char, int> counter;
        for (const char ch : s) {
            counter[ch]++;
        }
        
        unordered_set<char> added;
        ostringstream ss;
        
        int min_char_i = 0;
        for (int i = 0; i < s.size(); i++) {
            char ch = s[i];
            if (added.find(ch) != added.end()) {
                continue;
            }
            
            // strictly smaller than so if there are multiple occurence of the smallest char, the leftmost one is used
            if (ch < s[min_char_i]) {
                min_char_i = i;
            }
            if (--counter[ch] == 0) {
                ss << ch;
                added.insert(ch);
                min_char_i = i+1;
            }
        }
        
        return ss.str();
    }
};