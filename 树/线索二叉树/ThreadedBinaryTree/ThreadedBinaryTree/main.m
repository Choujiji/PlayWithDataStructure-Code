//
//  main.m
//  ThreadedBinaryTree
//
//  Created by mac on 2019/4/10.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 结点标识符 */
typedef enum {
    /** 是孩子结点 */
    Link,
    /** 是前趋/后缀结点 */
    Thread
} PointerTag;

/** 声明的数据类型 */
typedef char TElemType;

/** 线索二叉树结点结构体 */
typedef struct BiThrNode {
    /** 数据域 */
    TElemType data;
    /** 左结点指针 */
    struct BiThrNode *lchild;
    /** 右结点指针 */
    struct BiThrNode *rchild;
    /** 左标识符 */
    PointerTag LTag;
    /** 右标识符 */
    PointerTag RTag;
} BiThrNode, *BiThrTree;

/** 当前访问节点 */
BiThrTree currentP = NULL;

/** 中序遍历线索化 */
void InThreading(BiThrTree p) {
    if (!p) {
        // 结点不存在，返回
        return;
    }
    
    if (!p->lchild && !p->rchild) {
        // 左右子结点均不存在，即是叶子结点【防止最后一个结点无修改RTag】
        p->LTag = Thread;
        p->RTag = Thread;
    }
    
    // 递归线索化左结点
    InThreading(p->lchild);
    
    // 自身数据线索化（由于是中序遍历【左--中--右】，此时右结点还没有访问到，故只处理当前和前一个结点即可）
    
    if (!(p->lchild)) {
        // 左结点为空，即没有左孩子，故当前指向前趋结点
        p->LTag = Thread;
        p->lchild = currentP;
    } else {
        // 包含左孩子
        p->LTag = Link;
    }
    
    if (currentP) {
        if (!(currentP->rchild)) {
            // 前一个结点的右结点指针为空，即没有右孩子，故指向后继结点（当前结点）
            currentP->RTag = Thread;
            currentP->rchild = p;
        } else {
            // 包含右孩子
            currentP->RTag = Link;
        }
    }
    
    
    // 记录当前结点
    currentP = p;
    
    // 递归线索化右结点
    InThreading(p->rchild);
}

/** 创建二叉树（前序遍历） */
void CreateBiTree(BiThrTree *T) {
    TElemType ch;
    scanf("%c", &ch);
    if (ch == '#') {
        *T = NULL; // 此结点无数据
        return;
    } else {
        // 分配空间，创建新结点
        *T = (BiThrTree)malloc(sizeof(BiThrNode));
        if (!*T) {
            exit(OVERFLOW);
        }
        
        // 前序遍历方式赋值
        (*T)->data = ch;
        
        // 递归左右节点
        CreateBiTree(& (*T)->lchild);
        CreateBiTree(& (*T)->rchild);
    }
}

/** 中序遍历【标准递归方式】 */
void InOrderTraverse(BiThrTree T) {
    if (T == NULL) {
        return;
    }
    
    if (T->LTag == Link) {
        // 有左孩子节点，递归访问左孩子结点
        InOrderTraverse(T->lchild);
    }
    
    // 访问根结点
    TElemType data = (T->data);
    printf("data = %hhd\n",  data);
    printf("LTag - %d\n", T->LTag);
    printf("RTag - %d\n", T->RTag);
    
    if (T->RTag == Link) {
        // 有右孩子节点，递归访问右孩子结点
        InOrderTraverse(T->rchild);
    }
}

/** 向线索二叉树中插入头结点 */
BiThrTree insertHeadNodeToBiThrTree(BiThrTree biTree) {
    if (biTree == NULL) {
        return NULL;
    }
    
    // 创建头节点
    BiThrTree headNode = (BiThrTree)malloc(sizeof(BiThrNode));
    // 左孩子指向线索二叉树的根结点
    headNode->lchild = biTree;
    headNode->LTag = Link;
    // 右孩子指向中序遍历的最后一个结点
    BiThrTree inOrderTailNode = biTree;
    while (inOrderTailNode->RTag == Link) {
        inOrderTailNode = inOrderTailNode->rchild;
    }
    // 此时inOrderTailNode即为最后一个结点
    headNode->rchild = inOrderTailNode;
    headNode->RTag = Thread; // 并不是右孩子
    
    // targetNode的后继结点指向头结点
    inOrderTailNode->rchild = headNode;
    
    // 中序遍历的第一个结点的前趋结点指向头结点
    BiThrTree inOrderFirstNode = biTree;
    while (inOrderFirstNode->LTag == Link) {
        inOrderFirstNode = inOrderFirstNode->lchild;
    }
    // 此时inOrderFirstNode即为第一个结点
    inOrderFirstNode->lchild = headNode;
    
    return headNode;
}

/** 中序遍历【扫描二叉链表方式】 */
void InOrderTraverse_Thr(BiThrTree T) {
    // 中序遍历，即从头结点开始扫描，
    // 1. 首先找到最左边的结点（没有左孩子的），
    // 2. 然后找其后继结点（子树的根），
    // 3. 最后是其右结点（右孩子或后继）
    // 直到扫描到的结点是头结点，结束
    
    // 指向根结点（从根结点开始）
    BiThrTree currentNode = T->lchild;
    
    // 遍历结束时，指向头结点
    while (currentNode != T) {
        // 1. 找到当前子树最左边的结点（没有左孩子的）
        while (currentNode->LTag == Link) {
            // 有左孩子，继续查找
            currentNode = currentNode->lchild;
        }
        // 找到了最左边的结点，输出
        printf("%hhd ", currentNode->data);
        
        // 2. 一直向后找到所有后继结点（即对应子树的根）
        while (currentNode->RTag == Thread && currentNode->rchild != T) {
            currentNode = currentNode->rchild;
            // 找到了后继结点，输出
            printf("%hhd ", currentNode->data);
        }
        
        // 3. 指向右结点（下一个结点，不管结点类型，准备下次循环）
        currentNode = currentNode->rchild;
    }
    printf("\n");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //        ABDH##I##EJ###CF##G## 前序创建序列1
        //        ABD#E###C## 前序创建序列2
        
        // 创建二叉树【中序遍历】
        BiThrTree biTree = NULL;
        CreateBiTree(&biTree);
        printf("创建完成！\n");
        
        // 中序线索化
        InThreading(biTree);
        printf("中序线索化完成！\n");
        
        // 中序遍历输出
        InOrderTraverse(biTree);
        printf("中序遍历完成！\n");
        
        
        // 创建双向链表（向线索二叉树的根结点前插入头结点）
        biTree = insertHeadNodeToBiThrTree(biTree);
        // 中序遍历改双向链表
        InOrderTraverse_Thr(biTree);
        printf("中序遍历双向链表完成！\n");
    }
    return 0;
}
