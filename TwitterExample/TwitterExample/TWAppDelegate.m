//
//  RMAppDelegate.m
//  RESTMagic
//
//  Created by Jason Katzer on 6/30/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "TWAppDelegate.h"
#import <RESTMagic/RESTMagic.h>

@implementation TWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];    
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:[apiManager viewControllerForResourceAtPath:@"trends/daily.json"]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
