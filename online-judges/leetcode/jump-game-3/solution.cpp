class Solution {
public:
    bool canReach(vector<int>& arr, int start) {
        vector<bool> visited(arr.size(), false);
        visited[start] = true;
        
        queue<int> q;
        q.push(start);
        
        while (!q.empty()) {
            int i = q.front(); q.pop();
            if (arr[i] == 0) {
                return true;
            }
            
            int j = i - arr[i];
            if (j >= 0 && !visited[j]) {
                if (arr[j] == 0) {
                    return true;
                }
                visited[j] = true;
                q.push(j);
            }
            
            int k = i + arr[i];
            if (k < arr.size() && !visited[k]) {
                if (arr[k] == 0) {
                    return true;
                }
                visited[k] = true;
                q.push(k);
            }
        }
        return false;
    }
};