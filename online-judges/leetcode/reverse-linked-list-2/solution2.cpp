class Solution {
public:
    ListNode* reverseBetween(ListNode* head, int left, int right) {    
        ListNode dummy(0, head);
        
        ListNode* pre = &dummy;
        for (int i = 0; i < left-1; i++) {
            pre = pre->next;
        }
        
        ListNode* curr = pre->next;
        for (int i = 0; i < right -left; i++) {
            tie(pre->next, curr->next, curr->next->next) 
                = make_tuple(curr->next, curr->next->next, pre->next);
        }
        
        return dummy.next;
    }
};