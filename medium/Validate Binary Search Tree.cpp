#include <limits>

struct TreeNode {
	int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
	int lastValue = std::numeric_limits<int>::min();
public:
	bool isValidBST(TreeNode* root) {
		if (root == nullptr) { return true; }
		if (!isValidBST(root->left)) { return false; }
		if (lastValue >= root->val) { return false; }
		lastValue = root->val;
		return isValidBST(root->right);
	}
};