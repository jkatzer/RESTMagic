//
//  RMAPIManager.m
//  RESTMagic
//
//  Created by Jason Katzer on 7/7/12.
//  Copyright (c) 2012 Jason Katzer. All rights reserved.
//
//
// Do we want to cache all objects?
// Ship binaries with javascript frameworks downloaded?
// Download zipped packages with all reources, including templates?
// or maybe without templates?

#import "RMAPIManager.h"
#import "SynthesizeSingleton.h"

@implementation RMAPIManager
SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_CUSTOM_METHOD(RMAPIManager, sharedAPIManager)

@synthesize baseURL;

-(NSString *)nameForResourceAtPath:(NSString *)path
{

    return [path componentsSeparatedByString:@"/"][0];
    
}

-(NSString *)nameForResourceAtURL:(NSURL *)url
{
    return [[[[url path] componentsSeparatedByString:@"/"] lastObject] stringByReplacingOccurrencesOfString:@".json" withString:@""];
}



-(NSURL *)URLForResourceAtPath:(NSString *)path
{
    
    return [NSURL URLWithString:path relativeToURL:baseURL];

}


-(NSString *)urlForResourceAtPath:(NSString *)path
{
    
    return [[self URLForResourceAtPath:path] absoluteString];
    
}

-(NSString *)templateUrlForResourceAtUrl:(NSURL *)url
{
    //check for parts of the path that are actually unique identifiers

    NSString *lastPartOfPath = [[url pathComponents] lastObject];

    NSString *potentialId = [[lastPartOfPath componentsSeparatedByString:@"."] objectAtIndex:0];
            
    if ([potentialId intValue] != 0) {
        NSMutableArray *restOfPath = [NSMutableArray arrayWithArray:[[url path]componentsSeparatedByString:@"/"]];
        [restOfPath removeLastObject];
        
        NSString *pathBeforeId = [restOfPath componentsJoinedByString:@"/"];
        
        NSString *pathAfterId = [[lastPartOfPath componentsSeparatedByString:@"."] lastObject];
        return [NSString stringWithFormat:@"templates/%@%@/id.%@", [url host], pathBeforeId, pathAfterId];
    }
    
    
    return [NSString stringWithFormat:@"templates/%@%@", [url host], [url path]];
}




-(RMViewController *)viewControllerForResourceAtPath:(NSString *)path
{
    
    NSString* resourceName = [self nameForResourceAtPath:path];
    resourceName= [resourceName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[resourceName substringToIndex:1] uppercaseString]];

    
    NSString *potentialViewControllerName = [NSString stringWithFormat:@"%@%@ViewController",@"RM",resourceName];
    
    id viewController = [[NSClassFromString(potentialViewControllerName) alloc] init];
    
    if (viewController) {
        return viewController;
    }
    
    NSLog(@"trying view controller: %@",potentialViewControllerName);
    
    return [[RMViewController alloc] initWithResourceAtUrl:[self urlForResourceAtPath:path] withTitle:[self nameForResourceAtPath:path]];
    
}

-(RMViewController *)viewControllerForResourceAtURL:(NSURL *)url
{
 
    NSString* resourceName = [self nameForResourceAtURL:url];
    resourceName= [resourceName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[resourceName substringToIndex:1] uppercaseString]];
    
    
    NSString *potentialViewControllerName = [NSString stringWithFormat:@"%@%@ViewController",@"TW",resourceName];
    
//    id viewController = [[NSClassFromString(potentialViewControllerName) alloc] initWithResourceAtUrl:[url absoluteString] withTitle:[self nameForResourceAtURL:url]];
    
//    if (viewController) {
//        return viewController;
//    }
    
    
    
    NSLog(@"trying view controller: %@",potentialViewControllerName);

    
    return [[RMViewController alloc] initWithResourceAtUrl:[url absoluteString] withTitle:[self nameForResourceAtURL:url]];

}


@end
