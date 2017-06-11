//
//  GFTree.m
//  GFTree
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import "GFTree.h"

@interface GFTree ()

@property (nonatomic, retain) NSMutableDictionary * leafMap;

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
    if ([branch.class conformsToProtocol:@protocol(GFBranchProtocol)]) {
        NSString * branchName = NSStringFromClass(branch);
        if ([branch.class respondsToSelector:@selector(branchProtocol_name)]) {
            NSString * tempLeafName = [branch branchProtocol_name];
            branchName = tempLeafName.length > 0 ? tempLeafName : branchName;
        }
        [self.leafMap setValue:branch forKey:branchName];
    }
}

- (NSMutableDictionary *)leafMap {
    if (_leafMap == nil) {
        _leafMap = [[NSMutableDictionary alloc] init];
    }
    return _leafMap;
}

@end






