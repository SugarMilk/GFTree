//
//  ViewController.m
//  GFTree
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import "OneViewController.h"
#import "GFTree.h"
#import "TwoViewController.h"

@interface OneViewController () <GFClassProtocol>

@end

@implementation OneViewController

+ (void)load {
    [GFTree registerClass:self protocol:@protocol(GFOneProtocol)];
}

+ (NSString *)classProtocol_name {
    return @"aProtocol";
}

+ (NSInteger)classProtocol_level {
    return 10;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<GFTwoProtocol> aProtocol = [GFTree instanceOfClass:TwoViewController.class];
    [aProtocol sayGoodNight];
    
    NSArray * array = [GFTree instanceOfProtocol:@protocol(GFOneProtocol)];
//    NSLog(@"array:  %@", array);
    
    [GFTree loadAllClasses];
}

@end
