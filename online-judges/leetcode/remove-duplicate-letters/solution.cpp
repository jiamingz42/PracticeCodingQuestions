class Solution {
public:
    string removeDuplicateLetters(string s) {
        unordered_map<char, int> counter;
        for (const char ch : s) {
            counter[ch]++;
        }
        
        bool added[26];
        for (int i = 0; i < 26; i++) {
            added[i] = false;
        }
        
        ostringstream ss;
        
        int min_char_i = 0;
        while (min_char_i < s.size()) {
            for (int i = min_char_i; i < s.size(); i++) {
                char ch = s[i];
                if (added[ch-'a']) {
                    if (min_char_i == i) min_char_i++;
                    continue;
                }

                // strictly smaller than so if there are multiple occurence of the smallest char, the leftmost one is used
                if (ch < s[min_char_i]) {
                    min_char_i = i;
                }
                if (--counter[ch] == 0) {
                    ss << s[min_char_i];
                    added[s[min_char_i]-'a'] = true;
                    min_char_i++;
                    for (int j = min_char_i; j <= i; j++) {
                        counter[s[j]]++;
                    }
                    break;
                }
            }
        }
        
        return ss.str();
    }
};