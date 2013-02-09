//
//  RMAppDelegate.m
//  RESTMagic
//
//  Created by Jason Katzer on 6/30/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "TWAppDelegate.h"
#import "RMAPIManager.h"
#import "RMFirstViewController.h"
#import "RMSecondViewController.h"

@implementation TWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[RMFirstViewController alloc] initWithNibName:@"RMFirstViewController" bundle:nil];
    UIViewController *viewController2 = [[RMSecondViewController alloc] initWithNibName:@"RMSecondViewController" bundle:nil];
    
    
    
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];    
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:[apiManager viewControllerForResourceAtPath:@"trends/daily.json"]];

    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2, self.navigationController];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
