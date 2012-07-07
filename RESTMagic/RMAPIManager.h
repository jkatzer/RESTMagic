//
//  RMAPIManager.h
//  RESTMagic
//
//  Created by Jason Katzer on 7/7/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

//TODO: make this a singleton

#import <UIKit/UIKit.h>
#import "RMViewController.h"

@interface RMAPIManager : NSObject
{
    NSURL* baseURL;
}


-(id)initWithBaseURL:(NSURL *)URL;
-(NSString *)nameForResourceAtPath:(NSString *)path;
-(NSURL *)URLForResourceAtPath:(NSString *)path;
-(NSString *)urlForResourceAtPath:(NSString *)path;
-(RMViewController *)viewControllerForResourceAtPath:(NSString *)path;

@end
