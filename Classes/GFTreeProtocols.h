//
//  GFTreeProtocols.h
//  GFTree
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GFClassProtocol <NSObject>

+ (BOOL)classProtocol_singleton;
+ (NSString *)classProtocol_name;
+ (NSInteger)classProtocol_level;
+ (id)classProtocol_create;

@end

@protocol GFOneProtocol <NSObject>

- (void)sayGoodMorning;

@end

@protocol GFTwoProtocol <NSObject>

- (void)sayGoodNight;

@end
