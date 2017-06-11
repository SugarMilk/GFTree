//
//  OneViewController.m
//  GFTree
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import "TwoViewController.h"
#import "GFTree.h"

@interface TwoViewController () <GFClassProtocol, GFTwoProtocol>

@end

@implementation TwoViewController

+ (void)load {
    [GFTree registerClass:self protocol:@protocol(GFOneProtocol)];
    [GFTree registerClass:self protocol:@protocol(GFTwoProtocol)];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

+ (BOOL)classProtocol_singleton {
    return YES;
}

+ (NSInteger)classProtocol_level {
    return 100;
}

- (void)sayGoodNight {
    NSLog(@"RUN METHOD:  %s", __FUNCTION__);
}

//+ (NSString *)classProtocol_name {
//    return nil;
//}

@end
