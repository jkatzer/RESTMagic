//
//  RMAPIManager.m
//  RESTMagic
//
//  Created by Jason Katzer on 7/7/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//

#import "RMAPIManager.h"
#import "SynthesizeSingleton.h"

@implementation RMAPIManager
SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_CUSTOM_METHOD(RMAPIManager, sharedAPIManager)

@synthesize baseURL;

-(NSString *)nameForResourceAtPath:(NSString *)path
{
    
    
    return [path componentsSeparatedByString:@"/"][0];
    
}

-(NSURL *)URLForResourceAtPath:(NSString *)path
{
    
    return [NSURL URLWithString:path relativeToURL:baseURL];

}


-(NSString *)urlForResourceAtPath:(NSString *)path
{
    
    return [[self URLForResourceAtPath:path] absoluteString];
    
}


-(RMViewController *)viewControllerForResourceAtPath:(NSString *)path
{
    
    return [[RMViewController alloc] initWithResourceAtUrl:[self urlForResourceAtPath:path] withTitle:[self nameForResourceAtPath:path]];
    
}

@end
