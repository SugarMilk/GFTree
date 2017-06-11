//
//  GFTree.h
//  GFTree
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFTreeProtocols.h"

@interface GFTree : NSObject

+ (void)registerBranch:(Class<GFBranchProtocol>)branch leaf:(Protocol *)leaf;

@end
