//
//  GFTree.m
//  GFTree
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import "GFTree.h"

@interface GFTree ()

@property (nonatomic, retain) NSMutableDictionary<NSString *, NSArray<Protocol *> *> * classMap;
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

+ (void)registerClass:(Class<GFClassProtocol>)aClass protocol:(Protocol *)aProtocol {
    [[self shared] registerClass:aClass protocol:aProtocol];
}

- (void)registerClass:(Class<GFClassProtocol>)aClass protocol:(Protocol *)aProtocol {
    if ([(id)aClass conformsToProtocol:@protocol(GFClassProtocol)]) {
        NSArray * previous = self.classMap[(id)aClass];
        NSMutableArray * leaves = [NSMutableArray array];
        [leaves addObjectsFromArray:previous];
        [leaves addObject:aProtocol];
        self.classMap[(id)aClass] = leaves;
    }
}

+ (id)instanceOfClass:(Class<GFClassProtocol>)aClass {
    return [[self shared] instanceOfClass:aClass];
}

- (id)instanceOfClass:(Class<GFClassProtocol>)aClass {
    id aProtocol = self.singletonMap[(id)aClass];
    if (aProtocol) return aProtocol;
    
    if ([(id)aClass conformsToProtocol:@protocol(GFClassProtocol)]) {
        if ([(id)aClass respondsToSelector:@selector(classProtocol_create)]) {
            if ([(id)aClass respondsToSelector:@selector(classProtocol_singleton)]) {
                return self.singletonMap[(id)aClass] = [(id)aClass classProtocol_create];
            }
        } else {
            if ([(id)aClass respondsToSelector:@selector(classProtocol_singleton)]) {
                return self.singletonMap[(id)aClass] = [[(id)aClass alloc] init];
            }
        }
    }

    return [[(id)aClass alloc] init];
}

+ (NSArray *)instanceOfProtocol:(Protocol *)aProtocol {
    return [[self shared] instanceOfProtocol:aProtocol];
}

- (NSArray *)instanceOfProtocol:(Protocol *)aProtocol {
    NSMutableArray * classes = [NSMutableArray array];
    
    for (Class class in self.classMap) {
        NSArray<Protocol *> * protocols = self.classMap[(id)class];
        for (Protocol * protocol in protocols) {
            if (aProtocol == protocol) {
                [classes addObject:class];
            }
        }
    }
    
    NSMutableArray * instances = [NSMutableArray array];
    
    for (Class class in classes) {
        [instances addObject:[self instanceOfClass:class]];
    }

    return instances;
}

+ (void)loadAllClasses {
    [[self shared] loadAllClasses];
}

- (void)loadAllClasses {
    NSMutableArray * classes = [NSMutableArray array];
    [classes addObjectsFromArray:self.classMap.allKeys];
    [classes sortUsingComparator:
     ^NSComparisonResult(Class<GFClassProtocol> class1, Class<GFClassProtocol> class2) {
         NSInteger level1 = 0, level2 = 0;
         if ([(id)class1 respondsToSelector:@selector(classProtocol_level)]) {
             level1 = [class1 classProtocol_level];
         }
         if ([(id)class2 respondsToSelector:@selector(classProtocol_level)]) {
             level2 = [class2 classProtocol_level];
         }
         return level1 > level2;
    }];
}

- (NSMutableDictionary<NSString *, NSArray<Protocol *> *> *)classMap {
    if (_classMap == nil) {
        _classMap = [[NSMutableDictionary alloc] init];
    }
    return _classMap;
}

- (NSMutableDictionary<NSString *, id> *)singletonMap {
    if (_singletonMap == nil) {
        _singletonMap = [[NSMutableDictionary alloc] init];
    }
    return _singletonMap;
}

@end






