//
//  main.m
//  BinaryTree_Base
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 这里定义TElemType为字符类型 */
typedef char TElemType;

/** 二叉链表的结点结构体 */
typedef struct BiTNode {
    /** 数据域 */
    TElemType data;
    /** 左孩子节点指针 */
    struct BiTNode *lchild;
    /** 右孩子节点指针 */
    struct BiTNode *rchild;
} BiTNode, *BiTree;

/** 创建二叉树【前序遍历法创建：根--左--右】 */
void CreateBiTree(BiTree *T) {
    TElemType ch;
    scanf("%c", &ch);
    if (ch == '#') {
        *T = NULL; // 代表此结点位置无数据（数据为空）
        return;
    } else {
        // 分配空间，创建新结点
        *T = (BiTree)malloc(sizeof(BiTNode));
        // 内存分配失败，退出
        if (!*T) {
            exit(OVERFLOW);
        }
        
        // 前序遍历方式赋值
        
        // 1. 赋值根节点
        (*T)->data = ch;
        // 2. 左孩子结点递归
        CreateBiTree(&((*T)->lchild));
        // 3. 右孩子结点递归
        CreateBiTree(&((*T)->rchild));
    }
}

/** 前序遍历 */
void PreOrderTraverse(BiTree *T) {
    if (*T == NULL) {
        return;
    }
    // 访问根结点
    TElemType data = ((*T)->data);
    printf("%hhd\n",  data);
    // 递归访问左孩子结点
    PreOrderTraverse(&((*T)->lchild));
    // 递归访问右孩子结点
    PreOrderTraverse(&((*T)->rchild));
}

/** 中序遍历 */
void InOrderTraverse(BiTree *T) {
    if (*T == NULL) {
        return;
    }
    
    // 递归访问左孩子结点
    InOrderTraverse(&((*T)->lchild));
    // 访问根结点
    TElemType data = ((*T)->data);
    printf("%hhd\n",  data);
    // 递归访问右孩子结点
    InOrderTraverse(&((*T)->rchild));
}

/** 后序遍历 */
void PostOrderTraverse(BiTree *T) {
    if (*T == NULL) {
        return;
    }
    
    // 递归访问左孩子结点
    PostOrderTraverse(&((*T)->lchild));
    // 递归访问右孩子结点
    PostOrderTraverse(&((*T)->rchild));
    // 访问根结点
    TElemType data = ((*T)->data);
    printf("%hhd\n",  data);
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BiTree biTree = NULL;
        CreateBiTree(&biTree);
        printf("创建完成！\n");
        
        PreOrderTraverse(&biTree);
        printf("前序遍历完成！\n");
        
        InOrderTraverse(&biTree);
        printf("中序遍历完成！\n");
        
        PostOrderTraverse(&biTree);
        printf("后序遍历完成！\n");
    }
    return 0;
}
