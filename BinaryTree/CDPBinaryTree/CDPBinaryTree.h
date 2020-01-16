//
//  CDPBinaryTree.h
//  BinaryTree
//
//  Created by CDP on 2020/1/14.
//  Copyright © 2020 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface CDPBinaryTree : NSObject
//整理了一些二叉树的相关方法，方便理解
//https://github.com/cdpenggod/CDPBinaryTree.git

/**
 *  节点值
 */
@property (nonatomic,assign) NSInteger value;

/**
 *  左节点
 */
@property (nonatomic,strong) CDPBinaryTree *left;

/**
 *  右节点
 */
@property (nonatomic,strong) CDPBinaryTree *right;


#pragma mark - 基础方法

/**
 *  初始化一个二叉树或节点
 */
+(instancetype)createWithValue:(NSInteger)value left:(CDPBinaryTree *)left right:(CDPBinaryTree *)right;

/**
 *  根据value数组初始化二叉树
 *  (元素最好为NSNumber，第一个为根节点，后面的按顺序<=根节点的左子树，>根节点的右子树)
 */
+(instancetype)createWithValueArr:(NSArray *)valueArr;

/**
 *  添加节点
 *  (按照<=根节点的左子树，>根节点的右子树添加，tree为空则返回根节点)
 */
+(CDPBinaryTree *)addTree:(CDPBinaryTree *)tree value:(NSInteger)value;

#pragma mark - 二叉树其他相关方法

/**
 *  翻转二叉树
 */
+(void)invertTree:(CDPBinaryTree *)tree;

/**
 *  先序遍历
 */
+(void)firstTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block;

/**
 *  中序遍历
 */
+(void)midTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block;

/**
 *  后序遍历
 */
+(void)lastTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block;

/**
 *  广度优先遍历(层次遍历)
 */
+(void)levelTraverseWithTree:(CDPBinaryTree *)tree doWithNode:(void(^)(CDPBinaryTree *node))block;

/**
 *  获取二叉树深度
 */
+(NSInteger)getDepthWithTree:(CDPBinaryTree *)tree;

/**
 *  获取二叉树宽度
 */
+(NSInteger)getWidthWithTree:(CDPBinaryTree *)tree;

/**
 *  获取二叉树总节点数
 */
+(NSInteger)getNodeCountWithTree:(CDPBinaryTree *)tree;

/**
 *  获取二叉树某层节点数
 */
+(NSInteger)getNodeCountWithLevel:(NSInteger)level tree:(CDPBinaryTree *)tree;

/**
 *  获取二叉树叶子节点数
 */
+(NSInteger)getLeafCountWithTree:(CDPBinaryTree *)tree;

/**
 *  在二叉树tree中查找node节点是否存在，并且保存节点路径到pathArr
 *  (pathArr不需要可不传，元素为CDPBinaryTree节点)
 */
+(BOOL)searchNode:(CDPBinaryTree *)node inTree:(CDPBinaryTree *)tree pathArr:(NSMutableArray *)arr;

/**
 *  是否完全二叉树
 */
+(BOOL)isCompleteBinaryTree:(CDPBinaryTree *)tree;

/**
 *  是否满二叉树
 */
+(BOOL)isFullBinaryTree:(CDPBinaryTree *)tree;

/**
 *  是否平衡二叉树
 */
+(BOOL)isAVLBinaryTree:(CDPBinaryTree *)tree;

/**
 *  根据value数组创建哈夫曼树(即最优二叉树)
 *  (元素为NSNumber,数组内最少两个value,否则返回nil)
 */
+(CDPBinaryTree *)createHuffmanTreeWithValueArr:(NSArray *)valueArr;





@end



