//
//  RMAppDelegate.m
//  RESTMagic
//
//  Created by Jason Katzer on 6/30/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "RMAppDelegate.h"
#import "RMAPIManager.h"
#import "RMFirstViewController.h"
#import "RMSecondViewController.h"

@implementation RMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[RMFirstViewController alloc] initWithNibName:@"RMFirstViewController" bundle:nil];
    UIViewController *viewController2 = [[RMSecondViewController alloc] initWithNibName:@"RMSecondViewController" bundle:nil];
    
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];
    apiManager.baseURL = [NSURL URLWithString:@"https://api.twitter.com/1/"];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2, [apiManager viewControllerForResourceAtPath:@"trends/daily.json"]];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}


-(BOOL)canOpenURL:(NSURL *)url {
    RMAPIManager *apiManager = [RMAPIManager sharedAPIManager];

    
    if ([url host] == [apiManager.baseURL host])
    {
        NSRange textRange;
        textRange = [[url path] rangeOfString:[[apiManager baseURL] path] options:NSCaseInsensitiveSearch];
    
        if(textRange.location != NSNotFound) {return YES;}
    }
    
    return NO;
}

-(void)openURL:(NSURL *)url{
    
    // look for native controller
    // make a new view controller
    // pass it to a navigation controller?
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
