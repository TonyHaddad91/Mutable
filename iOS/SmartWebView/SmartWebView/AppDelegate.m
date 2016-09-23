//
//  AppDelegate.m
//  SmartWebView
//
//  Created by Essam on 9/22/16.
//  Copyright © 2016 Essam. All rights reserved.
//

#import "AppDelegate.h"
#import "AssetsURLProtocol.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSURLProtocol registerClass:AssetsURLProtocol.class];

    return YES;
}

@end
