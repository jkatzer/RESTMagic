//
//  RMAppDelegate.m
//  RESTMagic
//
//  Created by Jason Katzer on 6/30/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "TWAppDelegate.h"
#import "RMAPIManager.h"

@implementation TWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];    
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:[apiManager viewControllerForResourceAtPath:@"trends/daily.json"]];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[self.navigationController, [apiManager viewControllerForResourceAtPath:@"users/show.json?user_id=2886871"]];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
