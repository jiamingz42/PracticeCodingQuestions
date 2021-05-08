class Solution {
public:
    bool canReach(vector<int>& arr, int start) {
        unordered_set<int> visited;
        visited.insert(start);
        
        queue<int> q;
        q.push(start);
        
        while (!q.empty()) {
            int i = q.front(); q.pop();
            if (arr[i] == 0) {
                return true;
            }
            
            int j = i - arr[i];
            if (j >= 0 && visited.find(j) == visited.end()) {
                visited.insert(j);
                q.push(j);
            }
            
            int k = i + arr[i];
            if (k < arr.size() && visited.find(k) == visited.end()) {
                visited.insert(k);
                q.push(k);
            }
        }
        return false;
    }
};