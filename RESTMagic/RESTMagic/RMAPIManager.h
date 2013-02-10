//
//  RMAPIManager.h
//  RESTMagic
//
//  Created by Jason Katzer on 7/7/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMViewController.h"

@class RMViewController;

@interface RMAPIManager : NSObject
{
    NSURL* baseURL;
    NSDictionary* settings;
}

@property (nonatomic, retain) NSURL* baseURL;

+(RMAPIManager *)sharedAPIManager;
-(NSString *)nameForResourceAtPath:(NSString *)path;
-(NSString *)nameForResourceAtURL:(NSURL *)url;
-(NSURL *)URLForResourceAtPath:(NSString *)path;
-(NSString *)urlForResourceAtPath:(NSString *)path;
-(NSString *)templateUrlForResourceAtUrl:(NSURL *)url;
-(RMViewController *)viewControllerForResourceAtPath:(NSString *)path;
-(RMViewController *)viewControllerForResourceAtURL:(NSURL *)url;
-(BOOL)canOpenURL:(NSURL *)url;
-(void)openURL:(NSURL *)URL withNavigationController:(UINavigationController*) navigationController;

@end