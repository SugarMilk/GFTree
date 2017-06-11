//
//  GFRoot.m
//  GFRoot
//
//  Created by 黄健 on 2017/6/11.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import "GFRoot.h"

@implementation GFRoot

+ (instancetype)shared {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSDictionary *antNestEvents =
        @{
          UIApplicationDidFinishLaunchingNotification:
              NSStringFromSelector(@selector(root_application:didFinishLaunchingWithOptions:)),
          };
        
        for (NSString *eventName in antNestEvents.allKeys) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:NSSelectorFromString(antNestEvents[eventName]) name:eventName object:nil];
        }
    }
    return self;
}

- (BOOL)root_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return [self application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
