//
//  RMAPIManager.h
//  RESTMagic
//
//  Created by Jason Katzer on 7/7/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMViewController.h"
#import "RMAuthViewController.h"

@interface RMAPIManager : NSObject
{
    NSURL* baseURL;
    NSDictionary* settings;
}

@property (nonatomic, retain) NSURL* baseURL;

+(RMAPIManager *)sharedAPIManager;
-(NSDictionary*)settings;
-(NSString *)nameForResourceAtPath:(NSString *)path;
-(NSString *)nameForResourceAtURL:(NSURL *)url;
-(NSURL *)URLForResourceAtPath:(NSString *)path;
-(NSString*) apiPathFromFullPath:(NSString *)fullPath;
-(NSString *)urlForResourceAtPath:(NSString *)path;
-(NSString *)templateUrlForResourceAtUrl:(NSURL *)url;
-(RMAuthViewController *)authViewControllerForResourceAtPath:(NSString *)path withPreviousViewController:(UIViewController*)previousController;
-(RMViewController *)viewControllerForResourceAtPath:(NSString *)path;
-(RMViewController *)viewControllerForResourceAtURL:(NSURL *)url;
-(RMViewController *)viewControllerForResourceAtPath:(NSString *)path withClassNamed:(NSString*)className;
-(BOOL)canOpenURL:(NSURL *)url;
-(void)openURL:(NSURL *)URL withNavigationController:(UINavigationController*) navigationController;
-(void)openURL:(NSURL *)URL withNavigationController:(UINavigationController*) navigationController shouldFlushAllViews:(BOOL)shouldFlushAllViews;
@end