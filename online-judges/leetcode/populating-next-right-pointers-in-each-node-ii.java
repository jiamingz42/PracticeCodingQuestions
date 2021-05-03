/**
 * Definition for binary tree with next pointer.
 * public class TreeLinkNode {
 *     int val;
 *     TreeLinkNode left, right, next;
 *     TreeLinkNode(int x) { val = x; }
 * }
 */
public class Solution {

    private TreeLinkNode nextLevelLeftmostNode, nextLevelMostRecentTouchNode;

    public void connect(TreeLinkNode root) {

        TreeLinkNode currNode = root;
        resetNextLevelNode();

        while (currNode != null) {
             while (currNode != null) {
                 visitNode(currNode.left);
                 visitNode(currNode.right);
                 currNode = currNode.next;
             }
             currNode = nextLevelLeftmostNode;
             resetNextLevelNode();
        }
    }

    private void resetNextLevelNode() {
        nextLevelLeftmostNode = null;
        nextLevelMostRecentTouchNode = null;
    }

    private void visitNode(TreeLinkNode node) {
        if (node != null) {
            if (nextLevelLeftmostNode == null)
                nextLevelLeftmostNode = node;
            if (nextLevelMostRecentTouchNode != null)
                nextLevelMostRecentTouchNode.next = node;
            nextLevelMostRecentTouchNode = node;
         }
    }

}
