//
//  OneViewController.m
//  GFTree
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import "OneViewController.h"
#import "GFTree.h"

@interface OneViewController () <GFBranchProtocol>

@end

@implementation OneViewController

+ (void)load {
    [GFTree registerBranch:self leaf:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

//+ (NSString *)branchProtocol_name {
//    return nil;
//}

@end
