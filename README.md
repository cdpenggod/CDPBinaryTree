# CDPBinaryTree二叉树
Some code about binary tree,to understand easily.
整理的一些二叉树的相关代码实现，便于理解。

### For example  下面是其中一些方法,其他方法自己看demo

Detail see demo.

先序遍历

+(void)firstTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block;

中序遍历

+(void)midTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block;

后序遍历

+(void)lastTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block;

广度优先遍历(层次遍历)

+(void)levelTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block;
