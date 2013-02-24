//
//  RMAPIManager.h
//  RESTMagic
//


#import <UIKit/UIKit.h>
#import "RMViewController.h"
#import "RMAuthViewController.h"

@interface RMAPIManager : NSObject

@property (nonatomic, retain) NSURL* baseURL;
@property (nonatomic, retain, readonly) NSDictionary* settings;

+(RMAPIManager *)sharedAPIManager;
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