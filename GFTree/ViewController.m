//
//  ViewController.m
//  GFTree
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import "ViewController.h"
#import "GFTree.h"

@interface ViewController () <GFBranchProtocol>

@end

@implementation ViewController

+ (void)load {
    [GFTree registerBranch:self leaf:nil];
}

+ (NSString *)branchProtocol_name {
    return @"leaf";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

@end
