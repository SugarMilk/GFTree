//
//  GFTree.m
//  GFTree
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import "GFTree.h"

@interface GFTree ()

@property (nonatomic, retain) NSMutableDictionary<NSString *, NSArray *> * branchMap;
@property (nonatomic, retain) NSMutableDictionary<NSString *, id> * singletonMap;

@end

@implementation GFTree

+ (instancetype)shared {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)registerBranch:(Class<GFBranchProtocol>)branch leaf:(Protocol *)leaf {
    [[self shared] registerBranch:branch leaf:leaf];
}

- (void)registerBranch:(Class<GFBranchProtocol>)branch leaf:(Protocol *)leaf {
    if ([(id)branch conformsToProtocol:@protocol(GFBranchProtocol)]) {
        NSArray * previous = self.branchMap[(id)branch];
        NSMutableArray * leaves = [NSMutableArray array];
        [leaves addObjectsFromArray:previous];
        [leaves addObject:leaf];
        self.branchMap[(id)branch] = leaves;
    }
}

+ (instancetype)leafOfBranch:(Class<GFBranchProtocol>)branch {
    return [[self shared] leafOfBranch:branch];
}

- (instancetype)leafOfBranch:(Class<GFBranchProtocol>)branch {
    if ([(id)branch conformsToProtocol:@protocol(GFBranchProtocol)]) {
        if ([(id)branch respondsToSelector:@selector(branchProtocol_singleton)]) {
            id leaf = self.singletonMap[(id)branch];
            if (leaf) {
                return leaf;
            } else if ([branch.class branchProtocol_singleton]) {
                return self.singletonMap[(id)branch] = [[(id)branch alloc] init];
            }
        }
    }
    return [[(id)branch alloc] init];
}

- (NSMutableDictionary<NSString *, NSArray *> *)branchMap {
    if (_branchMap == nil) {
        _branchMap = [[NSMutableDictionary alloc] init];
    }
    return _branchMap;
}

- (NSMutableDictionary<NSString *, id> *)singletonMap {
    if (_singletonMap == nil) {
        _singletonMap = [[NSMutableDictionary alloc] init];
    }
    return _singletonMap;
}

@end






