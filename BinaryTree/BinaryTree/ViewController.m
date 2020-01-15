//
//  ViewController.m
//  BinaryTree
//
//  Created by CDP on 2020/1/14.
//  Copyright © 2020 CDP. All rights reserved.
//

#import "ViewController.h"

#import "CDPBinaryTree.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //demo只展示部分方法，主要用于方便理解二叉树及代码实现，其他方法看.h自己用，
    
    //创建二叉树
    CDPBinaryTree *tree=[CDPBinaryTree createWithValueArr:@[@(5),@(1),@(2),@(3),@(3),@(4),@(6),@(9),@(13)]];
    
    //先序遍历
    [CDPBinaryTree firstTraverseWithTree:tree doWithNode:^(CDPBinaryTree *node) {
        NSLog(@"先序遍历:%ld",(long)node.value);
    }];
    
    //中序遍历
    [CDPBinaryTree midTraverseWithTree:tree doWithNode:^(CDPBinaryTree *node) {
        NSLog(@"中序遍历:%ld",(long)node.value);
    }];
    
    //后序遍历
    [CDPBinaryTree lastTraverseWithTree:tree doWithNode:^(CDPBinaryTree *node) {
        NSLog(@"后序遍历:%ld",(long)node.value);
    }];
    
    //广度优先遍历
    [CDPBinaryTree levelTraverseWithTree:tree doWithNode:^(CDPBinaryTree *node) {
        NSLog(@"广度优先遍历:%ld",(long)node.value);
    }];
}


@end
