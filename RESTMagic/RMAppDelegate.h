//
//  RMAppDelegate.h
//  RESTMagic
//
//  Created by Jason Katzer on 6/30/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>



-(BOOL)canOpenURL:(NSURL *)url;
-(void)openURL:(NSURL *)url;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
