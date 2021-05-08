/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
public:
    ListNode* reverseBetween(ListNode* head, int left, int right) {
        // leftTail          rightHead
        // 1 -> [2->3->4] -> 5
        
        // left <= right
        if (left == right) {
            return head;
        }
        
        ListNode dummy(0, head);
        
        ListNode *leftTail, *rightHead, *midHead, *midTail;
        ListNode *prev, *curr = &dummy, *next;
        for (int i = 1; i <= right; i++) {
            prev = curr;
            curr = curr->next;

            if (i == left) {
                leftTail = prev;
                midHead = curr;
            } else if (i == right) {
                midTail = curr;
                rightHead = curr->next;
            }
        }
        
        prev = nullptr;
        curr = midHead;
        while (curr != rightHead) {
            next = curr->next;
            
            curr->next = prev;
            
            prev = curr;
            curr = next;
        }
        
        leftTail->next = midTail;
        midHead->next = rightHead;
        
        return dummy.next;
    }
};