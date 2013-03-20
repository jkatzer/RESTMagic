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

//Singleton Method
+(RMAPIManager *)sharedAPIManager;


//Lazy naming methods
-(NSString *)nameForResourceAtPath:(NSString *)path;
-(NSString *)nameForResourceAtURL:(NSURL *)url;
-(NSString *) resourceNameForResourceAtPath:(NSString *)path;

//URL methods
-(NSURL *)URLForResourceAtPath:(NSString *)path;
-(NSString *)urlForResourceAtPath:(NSString *)path;
-(NSString*) apiPathFromFullPath:(NSString *)fullPath;


//Template Methods
-(NSString *)templateUrlForResourceAtUrl:(NSURL *)url;


//Methods for figuring out what viewcontroller subclass to use
-(NSString *) potentialViewControllerNameForResourceNamed:(NSString *)resourceName;



//Methods that return a uiviewcontroller subclass
-(RMAuthViewController *)authViewControllerForResourceAtPath:(NSString *)path withPreviousViewController:(UIViewController*)previousController;
-(RMViewController *)viewControllerForResourceAtPath:(NSString *)path;
-(RMViewController *)viewControllerForResourceAtURL:(NSURL *)url;
-(RMViewController *)viewControllerForResourceAtPath:(NSString *)path withClassNamed:(NSString*)className;


//URL handling methods
-(BOOL)canOpenURL:(NSURL *)url;
-(void)openURL:(NSURL *)URL withNavigationController:(UINavigationController*) navigationController;
-(void)openURL:(NSURL *)URL withNavigationController:(UINavigationController*) navigationController shouldFlushAllViews:(BOOL)shouldFlushAllViews;


//Centralized error handling
-(void)showErrorHtml:(NSString*)html withNavController:(UINavigationController*) navigationController;
-(void)handleError:(NSError*)error fromViewController:(UIViewController*)viewController;

//Centralized convenience methods to get a setting or default
-(NSURLCacheStoragePolicy)cachePolicy;
@end