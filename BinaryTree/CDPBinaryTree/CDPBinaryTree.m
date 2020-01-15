//
//  CDPBinaryTree.m
//  BinaryTree
//
//  Created by CDP on 2020/1/14.
//  Copyright © 2020 CDP. All rights reserved.
//

#import "CDPBinaryTree.h"

@implementation CDPBinaryTree

#pragma mark - 基础方法
//初始化一个二叉树或节点
+(instancetype)createWithValue:(NSInteger)value left:(CDPBinaryTree *)left right:(CDPBinaryTree *)right{
    CDPBinaryTree *tree=[CDPBinaryTree new];
    tree.value=value;
    tree.left=left;
    tree.right=right;
    return tree;
}
//根据value数组初始化二叉树
+(instancetype)createWithValueArr:(NSArray *)valueArr{
    CDPBinaryTree *tree=nil;
    
    for (NSInteger i=0;i<valueArr.count;i++) {
        NSInteger value=[valueArr[i] integerValue];
        
        tree=[CDPBinaryTree addTree:tree value:value];
    }
    return tree;
}
//添加节点
+(CDPBinaryTree *)addTree:(CDPBinaryTree *)tree value:(NSInteger)value{
    if (tree==nil) {
        //当前无节点
        tree=[CDPBinaryTree new];
        tree.value=value;
    }
    else if (value<=tree.value){
        //小于当前节点value，加入左边
        tree.left=[CDPBinaryTree addTree:tree.left value:value];
    }
    else{
        //加入右边
        tree.right=[CDPBinaryTree addTree:tree.right value:value];
    }
    
    return tree;
}
#pragma mark - 二叉树其他相关方法
//翻转二叉树
+(void)invertTree:(CDPBinaryTree *)tree{
    if ((tree==nil)||
        (tree.left==nil&&tree.right==nil)) {
        return;
    }
    //翻转左边
    [CDPBinaryTree invertTree:tree.left];
    //翻转右边
    [CDPBinaryTree invertTree:tree.right];
    
    //交换左右
    CDPBinaryTree *temp=tree.left;
    tree.left=tree.right;
    tree.right=temp;
}
//先序遍历
+(void)firstTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block{
    if (tree==nil) {
        return;
    }
    //根节点
    if (block) {
        block(tree);
    }
    
    //遍历左边
    [CDPBinaryTree firstTraverseWithTree:tree.left doWithNode:block];
    //遍历右边
    [CDPBinaryTree firstTraverseWithTree:tree.right doWithNode:block];
}
//中序遍历
+(void)midTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block{
    if (tree==nil) {
        return;
    }
    //遍历左边
    [CDPBinaryTree midTraverseWithTree:tree.left doWithNode:block];
    
    //根节点
    if (block) {
        block(tree);
    }
    
    //遍历右边
    [CDPBinaryTree midTraverseWithTree:tree.right doWithNode:block];
}
//后序遍历
+(void)lastTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block{
    if (tree==nil) {
        return;
    }
    //遍历左边
    [CDPBinaryTree lastTraverseWithTree:tree.left doWithNode:block];
    //遍历右边
    [CDPBinaryTree lastTraverseWithTree:tree.right doWithNode:block];
    
    //根节点
    if (block) {
        block(tree);
    }
}
//广度优先遍历(层次遍历)
+(void)levelTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block{
    if (tree==nil) {
        return;
    }
    //用数组存入遍历时所需节点，任务队列
    NSMutableArray *arr=[NSMutableArray new];
    //把根节点加入数组
    [arr addObject:tree];
    
    //按层循环遍历节点直到队列为空
    while (arr.count>0) {
        CDPBinaryTree *node=arr[0];
        
        //执行节点block操作
        if (block) {
            block(node);
        }
        
        //执行后数组移除该节点
        [arr removeObject:node];
        
        //数组加入此节点的子节点
        if (node.left) {
            [arr addObject:node.left];
        }
        if (node.right) {
            [arr addObject:node.right];
        }
    }
}
//获取二叉树深度
+(NSInteger)getDepthWithTree:(CDPBinaryTree *)tree{
    if (tree==nil) {
        return 0;
    }
    //无子节点
    if (tree.left==nil&&tree.right==nil) {
        return 1;
    }
    //左子树深度
    NSInteger leftDepth=[CDPBinaryTree getDepthWithTree:tree.left];
    //右子树深度
    NSInteger rightDepth=[CDPBinaryTree getDepthWithTree:tree.right];
    
    return MAX(leftDepth,rightDepth)+1;
}
//获取二叉树宽度
+(NSInteger)getWidthWithTree:(CDPBinaryTree *)tree{
    if (tree==nil) {
        return 0;
    }
    
    //生成节点任务队列
    NSMutableArray *arr=[NSMutableArray new];
    //添加根节点
    [arr addObject:tree];
    
    //记录宽度
    NSInteger width=1;
    
    //遍历所有层节点，节点最多的层宽度为二叉树宽度
    while (arr.count>0) {
        //记录当前层宽度
        NSInteger rowWidth=arr.count;
        
        //遍历当前层，替换数组内节点为下一层
        for (NSInteger i=0;i<rowWidth;i++) {
            //当前层第一个节点
            CDPBinaryTree *firstNode=arr[0];
            [arr removeObject:firstNode];
            
            //将该节点子节点加入数组
            if (firstNode.left) {
                [arr addObject:firstNode.left];
            }
            if (firstNode.right) {
                [arr addObject:firstNode.right];
            }
        }
        
        //当前记录宽度与该层宽度对比，获取大的为宽度
        width=MAX(width,arr.count);
    }
    
    return width;
}
//获取二叉树总节点数
+(NSInteger)getNodeCountWithTree:(CDPBinaryTree *)tree{
    if (tree==nil) {
        return 0;
    }
    
    //子节点数
    NSInteger leftCount=[CDPBinaryTree getNodeCountWithTree:tree.left];
    NSInteger rightCount=[CDPBinaryTree getNodeCountWithTree:tree.right];
    
    return leftCount+rightCount+1;
}
//获取某层节点数
+(NSInteger)getNodeCountWithLevel:(NSInteger)level tree:(CDPBinaryTree *)tree{
    if (tree==nil||level<1) {
        return 0;
    }
    if (level==1) {
        return 1;
    }
    //子树level-1层节点数
    NSInteger leftCount=[CDPBinaryTree getNodeCountWithLevel:level-1 tree:tree.left];
    NSInteger rightCount=[CDPBinaryTree getNodeCountWithLevel:level-1 tree:tree.right];
    
    return leftCount+rightCount;
}
//获取二叉树叶子节点数
+(NSInteger)getLeafCountWithTree:(CDPBinaryTree *)tree{
    if (tree==nil) {
        return 0;
    }
    if (tree.left==nil&&tree.right==nil) {
        //左右子树都为空则为叶子节点
        return 1;
    }
    //获取子树叶子节点数
    NSInteger leftCount=[CDPBinaryTree getLeafCountWithTree:tree.left];
    NSInteger rightCount=[CDPBinaryTree getLeafCountWithTree:tree.right];
    
    return leftCount+rightCount;
}
//判断二叉树是否相等
+(BOOL)judgeIsEqualWithTree:(CDPBinaryTree *)tree otherTree:(CDPBinaryTree *)otherTree{
    if (tree==nil&&otherTree==nil) {
        //都为空
        return YES;
    }
    if (tree==nil||otherTree==nil) {
        //有一个为空
        return NO;
    }
    if (tree.value==otherTree.value) {
        //value相等，开始判断子树
        BOOL leftEqual=[CDPBinaryTree judgeIsEqualWithTree:tree.left otherTree:otherTree.left];
        
        //左子树不相等那么直接返回，没必要判断右子树了
        if (leftEqual==NO) {
            return NO;
        }
        BOOL rightEqual=[CDPBinaryTree judgeIsEqualWithTree:tree.right otherTree:otherTree.right];
        
        //左子树已经相等，那么只用返回右子树结果
        return rightEqual;
    }
    else{
        //value不相等
        return NO;
    }
}
//在二叉树tree中查找node节点是否存在，并且保存节点路径到pathArr
+(BOOL)searchNode:(CDPBinaryTree *)node inTree:(CDPBinaryTree *)tree pathArr:(NSMutableArray *)arr{
    if (node==nil||tree==nil) {
        return NO;
    }
    
    //开始查找tree节点，并将节点加入路径
    if (arr) {
        [arr addObject:tree];
    }
    
    if (node==tree) {
        //查找节点为根节点
        return YES;
    }
    //在左子树中查找
    BOOL leftHave=[CDPBinaryTree searchNode:node inTree:tree.left pathArr:arr];
    if (leftHave==YES) {
        //左子树中存在
        return YES;
    }
    //左子树没找到，在右子树中查找
    BOOL rightHave=[CDPBinaryTree searchNode:node inTree:tree.right pathArr:arr];
    if (rightHave==YES) {
        //右子树中存在
        return YES;
    }
    
    //左右子树都没找到，则删除该节点路径并返回NO
    if (arr) {
        [arr removeObject:tree];
    }
    
    return NO;
}
//是否完全二叉树
+(BOOL)isCompleteBinaryTree:(CDPBinaryTree *)tree{
    if (tree==nil) {
        return NO;
    }
    if (tree.left==nil&&tree.right==nil) {
        //左右子树为空
        return YES;
    }
    if (tree.left==nil&&tree.right) {
        //左子树为空，右子树不为空
        return NO;
    }
    
    NSMutableArray *arr=[NSMutableArray new];
    [arr addObject:tree];
    
    //记录是否出现右子树为空的节点
    BOOL haveEmptyRight=NO;
    
    while (arr.count>0) {
        CDPBinaryTree *node=arr[0];
        
        [arr removeObject:node];
        
        if (node.left==nil&&node.right) {
            //左子树为空，右子树不为空
            return NO;
        }
        if (haveEmptyRight&&(node.left||node.right)) {
            //已出现右子树为空的节点情况下，后面节点不应该还有子节点
            //右子树为空的节点在完全二叉树中只可能存在最后一层
            return NO;
        }
        if (node.right==nil) {
            //出现右子树为空的节点
            haveEmptyRight=YES;
        }
        
        //该节点符合完全二叉树，现在将其子节点加入队列
        if (node.left) {
            [arr addObject:node.left];
        }
        if (node.right) {
            [arr addObject:node.right];
        }
    }
    
    //所有节点都符合完全二叉树，返回YES
    return YES;
}
//是否满二叉树
+(BOOL)isFullBinaryTree:(CDPBinaryTree *)tree{
    if (tree==nil) {
        return NO;
    }
    //获取深度
    NSInteger depth=[CDPBinaryTree getDepthWithTree:tree];
    
    //获取叶子节点数
    NSInteger count=[CDPBinaryTree getLeafCountWithTree:tree];
    
    //判断是否符合 底部叶子节点数=2^(深度-1)
    //ps:或者可以判断 总节点数=(2^深度)-1，即pow(2,depth)-1
    if (count==pow(2,depth-1)) {
        return YES;
    }
    else{
        return NO;
    }
}
//是否平衡二叉树
+(BOOL)isAVLBinaryTree:(CDPBinaryTree *)tree{
    //静态变量,记录节点的高度
    static NSInteger cdpHeight;
    
    if (tree==nil) {
        //高度为0
        cdpHeight=0;
        return NO;
    }
    if (tree.left==nil&&tree.right==nil) {
        //无子树
        cdpHeight=1;
        return YES;
    }
    
    //左子树是否平衡二叉树
    BOOL leftAVL=[CDPBinaryTree isAVLBinaryTree:tree.left];
    //记录左子树高度
    NSInteger leftHeight=cdpHeight;
    
    //右子树是否平衡二叉树
    BOOL rightAVL=[CDPBinaryTree isAVLBinaryTree:tree.right];
    //记录左子树高度
    NSInteger rightHeight=cdpHeight;
    
    //该节点总高度
    cdpHeight=MAX(leftHeight,rightHeight)+1;
    
    //判断该节点是否符合平衡二叉树(左右子树都为平衡二叉树且高度差不超过1)
    if (leftAVL&&rightAVL&&ABS(leftHeight-rightHeight)<=1) {
        return YES;
    }
    else{
        return NO;
    }
}




@end
